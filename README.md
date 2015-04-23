# WARNING

If you use this cookbook, ensure that you've pinned the version of this cookbook as well
as the wrapper cookbook. Changes will be made to this cookbook and its wrapper and if
your recipe or cookbook that impleiments it does not have the version pinned, you run the
risk of getting the newest, possibly buggy and untested cookbook.

You can do this by setting your depends in metadata.rb like so...
* depends 'mongodb-wrapper', '0.2.2'
* depends 'chef-mongodb', '1.3.9'

# Description
This cookbook acts as a wrapper for the chef-mongodb cookbook. In most cases you can reference
the recipes in this cookbook from your recipe to get a working mongo instance.

# Requirements
This was written and tested for Ubuntu but it may work on other platforms.

# Recipes
* `default.rb` - Adds the apt recipe, monitoring and log-maintenance
* `replset-namegen.rb` - Auto generates replicaset names based on scope, project, site and more if needed.
* `monitoring.rb` - Enables the mongo_ck.sh script which logs to syslog for Zenoss
* `log-maintenance.rb` - Enables cron jobs to run the log rotation script and clean up logs older than 5 days
* `relicaset.rb` - Sets up a replicaset node
* `node-priority-[0-3].rb` - Sets the priority of a node for voting members of a replicaset
* `multi_instance.rb` - Used for setting up two instances of mongodb on one host. The instances will
    use port 27017 and 27018.

# Attributes
## Basic:
* `mongodb[:package_name]` - Sets the name of the package that will be installed with apt
* `mongodb[:version]` - Sets the version of the mongodb package you would like to install
* `mongodb[:dbpath]` - Location for mongodb data directory, defaults to "/var/lib/mongodb"
* `mongodb[:logpath]` - Path for the logfiles, default is "/var/log/mongodb"
* `mongodb[:port]` - Port the mongod listens on, default is 27017
* `mongodb[:cluster_name]` - Name of the cluster, all members of the cluster must
    reference to the same name, as this name is used internally to identify all
    members of a cluster.
* `mongodb[:shard_name]` - Name of a shard, default is "default"
* `mongodb[:sharded_collections]` - Define which collections are sharded
* `mongodb[:replicaset_name]` - Define name of replicatset
* `mongodb[:espy_search_orgs]` - Lets you set the orgs that espy will search in for replicaset nodes.
    i.e. node.set['mongodb']['espy_search_orgs'] = ['cartoon-56m', 'cartoon-cop']
      or node.set['mongodb']['espy_search_orgs'] = ['cartoon', 'ten']

## Types
* `mongodb[:type][:replicaset]` - Set to true to enable replicaset on a node, default unset
* `mongodb[:type][:hidden]` - Sets a node to hidden. Node will get updates but
    will not serve traffic
* `mongodb[:type][:arbiter]` - Sets a node to arbiter. Node must have replication enabled
* `mongodb[:type][:mongos]` - Sets a node type to mongos. Used for sharding.
* `mongodb[:type][:configserver]` - Sets a nodes type to configserver. Used for sharding.
* `mongodb[:type][:mongod]` - This is the default type. Sets the node to mongodb daemon.
* `mongodb[:type][:singleton]` - Sets a node to type singleton. If default recipe alone is
    used from the chef-mongodb cookbook, this is the type that is set.

## Apt repository
APT repositories are assigned by including either the 10gen_repo recipe in the chef-mongodb cookbook, or using
    the apt recipe in this cookbook. You will need to assign the package_name attribute
    if you want something other than the default for each.

# Usage

## Single mongodb instance (does not use wrapper cookbook currently)
Simply assign the cookbooks default recipe and one of the apt recipes to the node or inside of
  your wrapper recipe.

* `recipe[:mongodb::10gen_repo]`
* `recipe[chef-mongodb]`

For the wrappers APT recipe (nurners Archive Server), use the following.

* `recipe[mongodb-wrapper::apt]`
* `recipe[chef-mongodb]`

## Replicasets
For replicasets you can use the following on your node or in your recipe.

* `recipe[mongodb-wrapper]`
* `recipe[mongodb-wrapper::replicaset]`

## Sharding
Currently there is no wrapper recipe set up for sharding. You will need to assign the default recipe
    along with the appropriate recipe for the type of node you are setting up. Assign a shard_name
    attribute for each of the mongod hosts shard cluster. You can use replset-namegen recipe to
    automatically set up the replicaset shard names using the shard_name you assigned. The cookbook
    uses this shard name to find each group of nodes for a shard.

### Set in your recipe:
* `mongodb[:shard_name] = "ShardName1"`

### Assign to node or in recipe that is assigned to node:
Shard Node

* `recipe[mongodb-wrapper::replset-namegen]`
* `recipe[chef-mongodb::shard]`

Mongos Node

* `recipe[mongodb-wrapper::replset-namegen]`
* `recipe[chef-mongodb::mongos]`

Config Server

* `recipe[mongodb-wrapper::replset-namegen]`
* `recipe[chef-mongodb::configserver]`


## Sharding + Replication
To enable replication on your shard nodes, simply add the replicaset recipe along with shard
    and replset-namegen

* `recipe[mongodb-wrapper::replicaset]`
