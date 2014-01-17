include_recipe "php::apt_repository"

[
  "php5-fpm",
  "php5-cli",
  "php5-common",
  "php5-curl",
  "php5-gd",
  "php5-geoip",
  "php5-gmp",
  "php5-imagick",
  "php5-intl",
  "php5-json",
  "php5-mcrypt",
  "php5-memcache",
  "php5-memcached",
  "php5-mysql",
  "php5-xdebug",
  "php-pear",
].each do |pkg|
  package pkg do
    action :install
  end
end

service "php5-fpm" do
  action :nothing
end

template "/etc/php5/fpm/pool.d/www.conf.erb" do
  source "www.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "php5-fpm"), :immediately
end

cache_dir = "#{Chef::Config[:file_cache_path]}/composer"

directory cache_dir do
  action :create
end

cache_file = "#{cache_dir}/composer.phar"

remote_file cache_file do
  source node['php']['composer']['url']
  mode "0777"
  action :create
  not_if { ::File.exists?(cache_file) }
end

link node['php']['composer']['bin'] do
  to cache_file
  action :create
end