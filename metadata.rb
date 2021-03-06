name              "memcached"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs memcached and provides a define to set up an instance of memcache via runit"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.2.1"
depends           "runit", "<= 0.16.2"
depends           "yum"
depends           "cluster_service_discovery"

recipe "memcached", "Installs and configures a memcached; init or runit based on the attribute"
recipe "memcached::initd-server", "Installs and configures a default memcached init.d service"
recipe "memcached::setup", "Installs memcached"

%w{ ubuntu debian redhat fedora centos scientific amazon }.each do |os|
  supports os
end

attribute "memcached/memory",
  :display_name => "Memcached Memory",
  :description => "Memory allocated for memcached instance",
  :default => "64"

attribute "memcached/port",
  :display_name => "Memcached Port",
  :description => "Port to use for memcached instance",
  :default => "11211"

attribute "memcached/user",
  :display_name => "Memcached User",
  :description => "User to run memcached instance as",
  :default => "nobody"

attribute "memcached/listen",
  :display_name => "Memcached IP Address",
  :description => "IP address to use for memcached instance",
  :default => "0.0.0.0"

attribute "memcached/install_initd",
  :display_name => "Run on init.d - true or false",
  :description => "boolean to decide what type of daemon to run",
  :default => "true"
