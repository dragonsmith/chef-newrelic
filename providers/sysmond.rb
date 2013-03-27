#
# Cookbook Name:: newrelic
# Provider:: sysmond
#
# Author:: Kirill Kouznetsov <agon.smith@gmail.com>
#
# Copyright 2013, Kirill Kouznetsov
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

action :install do
  nr_repo = apt_repository "newrelic" do
    distribution node['newrelic']['apt']['di
    uri node['newrelic']['apt']['repo']stribution']
    components node['newrelic']['apt']['components']
    key node['newrelic']['apt']['keyfile']
  end

  nr_pack = package node['newrelic']['package_name']

  if nr_repo.updated_by_last_action? or nr_pack.updated_by_last_action?
    new_resource.updated_by_last_action(true)
  end
end

action :configure do
  all_newrelic_res = run_context.resource_collection.all_resources.select do |resource|
    resource.resource_name == new_resource.resource_name
  end

  bad_invocations = all_newrelic_res.select do |resource|
    resource.key != all_newrelic_res.first.key
  end.count
  
  if bad_invocations > 0
    Chef::Log.warn("Resource #{new_resource} was invoked with different license keys for #{bad_invocations+1} times. This can break your system configuration!!! Please, be careful!!!")
  end

  directory "/var/run/newrelic" do
    owner "newrelic"
    group "newrelic"
  end

  directory "/etc/newrelic" do
    owner "root"
    group "root"
    mode 00755
    action :create
  end

  nr_temp = template "/etc/newrelic/nrsysmond.cfg" do
    source "nrsysmond.cfg.erb"
    owner "root"
    group "newrelic"
    mode "640"
    variables(
      :license_key => new_resource.key
    )
    notifies :restart, "service[newrelic-sysmond]"
  end

  nr_serv = service "newrelic-sysmond" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end

  if nr_temp.updated_by_last_action? or nr_serv.updated_by_last_action?
    new_resource.updated_by_last_action(true)
  end
end

action :disable do
  nr_serv = service "newrelic-sysmond" do
    supports :status => true, :restart => true, :reload => true
    action [ :disable, :stop ]
  end

  if nr_serv.updated_by_last_action?
    new_resource.updated_by_last_action(true)
  end
end

action :uninstall do
  nr_pack = package node['newrelic']['package_name'] do 
    action :uninstall
  end

  if nr_pack.updated_by_last_action?
    new_resource.updated_by_last_action(true)
  end
end

# vim: ts=2 sts=2 sw=2 et sta