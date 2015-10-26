#
# Cookbook Name:: newrelic
# Provider:: elastic
#
# Author:: Kirill Kouznetsov <agon.smith@gmail.com>
#
# Copyright 2015, Kirill Kouznetsov
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def initialize(new_resource, run_context)
  super(new_resource, run_context)

  if new_resource.path && new_resource.path != ''
    @path = new_resource.path
  else
    @path = "/home/#{new_resource.owner}/newrelic_elastic_#{new_resource.application_name}"
  end
end

action :deploy do
  package 'git-core'

  ruby = new_resource.ruby
  owner = new_resource.owner
  path = @path
  key = new_resource.key
  application_name = new_resource.application_name
  elastic_url = new_resource.elastic_url
  login = new_resource.login
  password = new_resource.password

  deploy_rs = deploy @path do
    repo node['newrelic']['elastic']['git_repo']
    revision new_resource.revision
    user new_resource.owner
    shallow_clone true
    symlinks(
      'config/newrelic_plugin.yml' => 'config/newrelic_plugin.yml'
    )
    action :deploy
    restart_command "/usr/bin/sudo /usr/bin/sv restart newrelic_elastic_#{new_resource.application_name}"
    scm_provider Chef::Provider::Git

    before_restart do
      rbenv_script 'bundle install' do
        rbenv_version ruby
        user owner
        group owner
        cwd path + '/current/'
        code 'bundle install'
      end

      directory path + '/shared/config' do
        owner owner
        group owner
        mode '0755'
      end

      template path + '/shared/config/newrelic_plugin.yml' do
        source 'newrelic_plugin.conf.erb'
        cookbook 'newrelic'
        owner owner
        group owner
        mode '0640'
        variables(
          license_key: key,
          project_name: "elastic_#{application_name}",
          url: elastic_url,
          username: login,
          password: password
        )
      end
    end
  end

  new_resource.updated_by_last_action(true) if deploy_rs.updated_by_last_action?
end

action :start do
  include_recipe 'runit'

  path = @path

  runit_rs = runit_service "newrelic_elastic_#{new_resource.application_name}" do
    template_name 'elastic'
    cookbook 'newrelic'
    default_logger true
    options(
      'home_path'   => "/home/#{new_resource.owner}",
      'app_path'    => path,
      'target_user' => new_resource.owner
    )
    restart_on_update false
  end

  # make runit service managable for onlinetours user.
  sudo "newrelic_elastic_#{new_resource.application_name}" do
    user new_resource.owner
    commands [
      "/usr/bin/sv start newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv stop newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv restart newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv term newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv kill newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv force-stop newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv force-restart newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv up newrelic_elastic_#{new_resource.application_name}",
      "/usr/bin/sv down newrelic_elastic_#{new_resource.application_name}"
    ]
    nopasswd true
    only_if { new_resource.owner != 'root' }
  end

  new_resource.updated_by_last_action(true) if runit_rs.updated_by_last_action?
end

action :uninstall do
  runit_service "newrelic_elastic_#{new_resource.application_name}" do
    action [:stop, :disable]
  end

  sudo "newrelic_elastic_#{new_resource.application_name}" do
    action :remove
  end

  directory @path do
    recursive true
    action :delete
  end

  new_resource.updated_by_last_action(true)
end

# vim: ts=2 sts=2 sw=2 et sta
