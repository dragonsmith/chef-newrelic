#
# Author:: Kirill Kouznetsov (<agon.smith@gmail.com>)
# Cookbook Name:: newrelic
# Attributes:: default
#
# Copyright 2012-2013, Kirill Kouznetsov
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

default['newrelic']['license_key']  = 'REPLACE_WITH_THE_REAL_ONE'
default['newrelic']['enabled']      = false
default['newrelic']['package_name'] = 'newrelic-sysmond'

default['newrelic']['apt']['repo']         = 'http://apt.newrelic.com/debian/'
default['newrelic']['apt']['keyfile']      = 'http://download.newrelic.com/548C16BF.gpg'
default['newrelic']['apt']['distribution'] = 'newrelic'
default['newrelic']['apt']['components']   = ['non-free']

# vim: ts=2 sts=2 sw=2 et sta
