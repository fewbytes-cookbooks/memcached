#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

include_recipe "memcached::setup"

if node['memcached']['install_initd']
  include_recipe "memcached::initd-server"
else

  # disable the default behavior of the package
  service "memcached" do
    action [:stop , :disable]
    supports :status => true, :start => true, :stop => true, :restart => true
  end

  memcached_instance "default" do
    port "11211"
    memory "64"
  end

end

