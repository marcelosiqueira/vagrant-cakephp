directory "/usr/share/php5/Cake1" do
  owner "www-data"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

node['cakephp1']['versions'].each do | version, should_install |
  git "/usr/share/php5/Cake1" do
    repository 'git://github.com/cakephp/cakephp.git'
    revision version
    action :checkout
    only_if { should_install }
  end
end

directory "/usr/share/php5/Cake2" do
  owner "www-data"
  group "www-data"
  mode  0755
  recursive true
  action :create
end

node['cakephp2']['versions'].each do | version, should_install |
  git "/usr/share/php5/Cake2" do
    repository 'git://github.com/cakephp/cakephp.git'
    revision version
    action :checkout
    only_if { should_install }
  end
end