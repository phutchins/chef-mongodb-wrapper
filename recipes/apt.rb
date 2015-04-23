# Set up the MongoDB APT repository

apt_repository "mongodb" do
  uri node["namespace"]["artifacts_url"] + "/ubuntu/mongodb"
  key node["namespace"]["artifacts_url"] + "/ubuntu/artifacts-ubuntu.key"
  distribution node["lsb"]["codename"]
  components ["main"]
  action :add
end
