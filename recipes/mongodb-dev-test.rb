node.set["mongodb"]["package"] = "mongodb-10gen"
node.set["mongodb"]["version"] = "2.2.3"

node.set["mongodb1"]["port"] = 27017
node.set["mongodb1"]["replicaset_name"] = "mongodb1_replset_name"
node.set["mongodb1"]["type"]["replicaset"] = true
node.set["mongodb2"]["port"] = 27018
node.set["mongodb2"]["replicaset_name"] = "mongodb2_replset_name"
node.set["mongodb2"]["type"]["replicaset"] = true

node.set["scope"] = "dev"
node.set["project"] = "phutchins"
node.set["site"] = "testing"

include_recipe "mongodb-wrapper::default"
#include_recipe "mongodb-wrapper::replset-namegen"
include_recipe "chef-mongodb::multi_instance"
