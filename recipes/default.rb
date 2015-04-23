#
# Cookbook Name:: mongodb-wrapper
# Recipe:: default
#
# Copyright 2013, Turner
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mongodb-wrapper::apt"
include_recipe "mongodb-wrapper::monitoring"
include_recipe "mongodb-wrapper::users"
include_recipe "mongodb-wrapper::log-maintenance"
