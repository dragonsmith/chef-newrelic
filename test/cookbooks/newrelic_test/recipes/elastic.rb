#
# Cookbook Name:: newrelic_test
# Recipe:: elastic
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

# Install ruby
node.set['rbenv']['user_installs'] = [{ 'user' => 'vagrant' }]

include_recipe 'ruby_rbenv::user_install'

node['ruby_build']['install_pkgs_cruby'].each do |pac|
  package pac
end

rbenv_ruby node['newrelic']['elastic']['ruby'] do
  user 'vagrant'
end

rbenv_global node['newrelic']['elastic']['ruby'] do
  user 'vagrant'
end

rbenv_gem 'bundler' do
  rbenv_version node['newrelic']['elastic']['ruby']
  action :install
  user 'vagrant'
end

newrelic_elastic 'nya_elastic' do
  key node['newrelic']['license_key']
  application_name 'neko'
  owner 'vagrant'
  login 'inu'
  password 'bow-wow'
  # action :deploy
end

# vim: ts=2 sts=2 sw=2 et sta
