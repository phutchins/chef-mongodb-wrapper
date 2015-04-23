# Sets up two instances of mongodb on one node wiht instance names mongodb1 and mongodb2
# You will need to override attributes using the instance name. i.e. port at the very least

include_recipe "chef-mongodb"
include_recipe "chef-mongodb::multi_instance"
include_recipe "mongodb-wrapper::default"
