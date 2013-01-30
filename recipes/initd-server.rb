#
# Cookbook Name:: memcached
# Recipe:: initd-server
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

# force the setting, since obviously this recipe was selected to run on purpose
node.set['memcached']['install_initd'] = true

service "memcached" do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true
end

case node['platform_family']
when "rhel", "fedora"
  template "/etc/sysconfig/memcached" do
    source "memcached.sysconfig.erb"
    owner "root"
    group "root"
    mode 00644
    variables(
      :listen => node['memcached']['listen'],
      :user => node['memcached']['user'],
      :port => node['memcached']['port'],
      :maxconn => node['memcached']['maxconn'],
      :memory => node['memcached']['memory']
    )
    notifies :restart, resources(:service => "memcached"), :immediately
  end
else
  template "/etc/memcached.conf" do
    source "memcached.conf.erb"
    owner "root"
    group "root"
    mode 00644
    variables(
      :listen => node['memcached']['listen'],
      :user => node['memcached']['user'],
      :port => node['memcached']['port'],
      :maxconn => node['memcached']['maxconn'],
      :memory => node['memcached']['memory']
    )
    notifies :restart, resources(:service => "memcached"), :immediately
  end
end

case node['lsb']['codename']
when "karmic"
  template "/etc/default/memcached" do
    source "memcached.default.erb"
    owner "root"
    group "root"
    mode 00644
    notifies :restart, resources(:service => "memcached"), :immediately
  end
end
