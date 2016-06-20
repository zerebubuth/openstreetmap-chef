#
# Cookbook Name:: web
# Recipe:: cgimap
#
# Copyright 2011, OpenStreetMap Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "tools"
include_recipe "web::base"

db_passwords = data_bag_item("db", "passwords")

package "openstreetmap-cgimap-bin"

template "/etc/init.d/cgimap" do
  owner "root"
  group "root"
  mode 0755
  source "cgimap.init.erb"
  variables :db_password => db_passwords["rails"]
end

if %w(database_offline api_offline).include?(node[:web][:status])
  service "cgimap" do
    action :stop
  end
else
  service "cgimap" do
    action [:enable, :start]
    supports :restart => true, :reload => true
    subscribes :restart, "dpkg_package[openstreetmap-cgimap-bin]"
    subscribes :restart, "file[/etc/init.d/cgimap]"
  end
end
