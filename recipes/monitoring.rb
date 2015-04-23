node.default["zenoss"]["class"] = "/Devices/Server/Linux/Mongo"

include_recipe 'monitoring-wrapper::prod'

directory node["mongodb"]["util_bin_dir"] do
  action :create
  mode 0775
  group "root"
  owner "root"
  recursive true
end

directory node["mongodb"]["util_conf_dir"] do
  action :create
  mode 0775
  group "root"
  owner "root"
  recursive true
end

directory node["mongodb"]["util_log_dir"] do
  action :create
  mode 0775
  group "root"
  owner "root"
  recursive true
end

template "#{node["mongodb"]["util_bin_dir"]}/mongodb_ck.sh" do
  source "mongodb_ck.sh.erb"
  owner "root"
  group "root"
  mode 0744
  action :create
  backup false
end

cookbook_file "#{node["mongodb"]["util_conf_dir"]}/mongodb_exclude.conf" do
  source "mongodb_exclude.conf"
  owner "root"
  group "root"
  mode 0744
  action :create
  backup false
end

cron "mongo_check" do
  command "#{node["mongodb"]["util_bin_dir"]}/mongodb_ck.sh > /dev/null 2>&1"
  minute "15"
  only_if do File.exist?("#{node["mongodb"]["util_bin_dir"]}/mongodb_ck.sh") end
end
