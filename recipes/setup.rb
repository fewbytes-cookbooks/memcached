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

# include epel on redhat/centos 5 and below in order to get the memcached packages
if node['platform_family'] == "rhel" and node['platform_version'].to_i < 6
 include_recipe "yum::epel"
end

package "memcached" do
  action :install
end

package "libmemcache-dev" do
  case node['platform_family']
  when "rhel", "fedora"
    package_name "libmemcached-devel"
  else
    package_name "libmemcache-dev"
  end
  action :install
end

