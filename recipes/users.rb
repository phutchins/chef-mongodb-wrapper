node.set["sudo"]["groups"] = %w<dev>

include_recipe 'users::dev'
include_recipe 'sudo'

