cookbook_file "#{node["mongodb"]["util_bin_dir"]}/mongo-log-rotate.sh" do
  source "mongo-log-rotate.sh"
  owner "root"
  group "root"
  mode 0744
  action :create
  backup false
end

cron "mongo_rotate" do
  command "#{node["mongodb"]["util_bin_dir"]}/mongo-log-rotate.sh > /dev/null 2>&1"
  hour "02"
  minute "00"
  only_if do File.exist?("#{node["mongodb"]["util_bin_dir"]}/mongo-log-rotate.sh") end
end

## TODO: Attributize the number of days to keep logs
cron "MongoDB_Log_Cleanup" do
  hour "3"
  minute "00"
  command "find #{node["mongodb"]["logpath"]} -mtime +5 -exec rm {} \\;"
end
