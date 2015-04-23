# Set up Replication Set name per environment and site

Chef::Log.info("Setting up replicaset_name...")

raise "SCOPE and PROJECT are required. SITE, CLUSTER and SHARD_NAME are optional." unless node["scope"] and node["project"]
#Chef::Log.info("Scope: #{node["scope"]}")
#Chef::Log.info("Project: #{node["project"]}")
#Chef::Log.info("Site: #{node["site"]}") if !node["site"].nil?
#Chef::Log.info("cluster: #{node["cluster"]}") if !node["cluster"].nil?
#Chef::Log.info("Shard_name: #{node["mongodb"]["shard_name"]}") if !node["mongodb"]["shard_name"].nil?

# Setting up the required attributes
labels = [ node["scope"], node["project"] ]

# Adding optional attributes if they exist
%w<site cluster>.each do |attr|
  if node[attr]
    labels << node[attr]
  end
end

# If we have not specified any instances, use the default instance name
if !node["mongodb"]["instances"].nil?
  mongodb_instances = node["mongodb"]["instances"]
else
  mongodb_instances = [ "mongodb" ]
end

# Run through all instances and create replicaset names for them using attributes
mongodb_instances.each { |instance|
  # Used to group 
  node.set[instance.to_sym]["cluster_name"] = labels.join '_'
  # Add shard name to replicaset name if we are creating a shard
  labels << node[instance.to_sym]["shard_name"] unless (node[instance.to_sym]["shard_name"].nil? && node[instance.to_sym]["type"]["shard"].nil? && node[instance.to_sym]["type"]["mongos"].nil? && node[instance.to_sym]["type"]["configserver"].nil?) 
  node.set[instance.to_sym]["replicaset_name"] = labels.join '_'
  Chef::Log.info("ReplicaSet_name: #{node[instance.to_sym]["replicaset_name"]}")
}
