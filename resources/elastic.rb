#
# Cookbook Name:: newrelic
# Resource:: elastic
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

actions :deploy, :start, :uninstall

default_action [:deploy, :start]

attribute :key, kind_of: String
attribute :elastic_url, kind_of: String, default: 'http://127.0.0.1:9200'
attribute :application_name, name_attribute: true, kind_of: String
attribute :path, kind_of: String
attribute :owner, kind_of: String, default: 'root'
attribute :login, kind_of: String
attribute :password, kind_of: String
attribute :revision, kind_of: String, default: node['newrelic']['elastic']['revision']
attribute :ruby, kind_of: String, default: node['newrelic']['elastic']['ruby']

# vim: ts=2 sts=2 sw=2 et sta
