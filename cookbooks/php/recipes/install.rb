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

ruby_block "edit fpm php.ini" do
  block do
    rc = Chef::Util::FileEdit.new("/etc/php5/fpm/php.ini")
    rc.search_file_replace_line(";date.timezone =", "date.timezone = 'America/Campo_Grande'")
    rc.search_file_replace_line("memory_limit = 128M", "memory_limit = 512M")
    rc.search_file_replace_line("post_max_size = 8M", "post_max_size = 32M")
    rc.search_file_replace_line("upload_max_filesize = 2M", "upload_max_filesize = 200M")
    rc.search_file_replace_line("max_execution_time = 30", "max_execution_time = 180")
    rc.search_file_replace_line("max_input_time = 60", "max_input_time = 120")
    rc.search_file_replace_line("error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT", "error_reporting = E_ALL")
    rc.search_file_replace_line(";include_path = \".:/usr/share/php\"", "include_path = \".:/usr/share/php5:/usr/share/php5/PEAR:/usr/share/php5/Cake2/lib:/usr/share/php5/Cake1/\"")
    rc.write_file
  end
end