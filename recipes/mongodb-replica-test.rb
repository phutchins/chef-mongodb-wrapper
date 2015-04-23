node.set["mongodb"]["package"] = "mongodb-10gen"
node.set["mongodb"]["version"] = "2.4.0"

node.set["mongodb"]["port"] = 27017
node.set["mongodb"]["replicaset_name"] = "mongodb1_replset_name"
node.set["mongodb"]["type"]["replicaset"] = true

node.set["scope"] = "dev"
node.set["project"] = "phutchins"
node.set["site"] = "testing1"

include_recipe "mongodb-wrapper::default"
include_recipe "mongodb-wrapper::replset-namegen"
include_recipe "chef-mongodb::replicaset"
