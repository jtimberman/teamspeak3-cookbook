#
# Author:: Joshua Timberman <joshua@housepub.org>
# Cookbook Name:: teamspeak3
# Recipe:: default
#
# Copyright 2008-2012, Joshua Timberman
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

base = "teamspeak3-server_linux-#{node['ts3']['arch']}"
basever = "#{base}-#{node['ts3']['version']}"

service "teamspeak3" do
  action :nothing
end

cached_installation_file = File.join(Chef::Config[:file_cache_path], "#{basever}.tar.gz")

remote_file cached_installation_file do
  source node['ts3']['url']
  mode 0644
  not_if { ::FileTest.exists?(cached_installation_file) }
end

u = user "teamspeak-server" do
  action :nothing
  system true
  home "#{node['ts3']['install_dir']}/#{base}"
end

u.run_action(:create)

directory "#{node['ts3']['install_dir']}/#{base}" do
  owner "teamspeak-server"
  group "teamspeak-server"
end

execute "install_ts3" do
  cwd "#{node['ts3']['install_dir']}"
  user "teamspeak-server"
  command "tar zxf #{ cached_installation_file }"
  not_if { ::FileTest.exists?("#{node['ts3']['install_dir']}/#{base}/ts3server_linux_#{node['ts3']['arch']}") }
end

link "#{node['ts3']['install_dir']}/teamspeak3" do
  to "#{node['ts3']['install_dir']}/#{base}"
end

case node['platform']
when "ubuntu","debian"
  include_recipe "runit" unless node['ts3']['skip_runit_installation']
  runit_service "teamspeak3"
when "arch"
  template "/etc/rc.d/teamspeak3" do
    source "teamspeak3.rc.d.erb"
    owner "root"
    group "root"
    mode 0755
    variables :base => "#{node['ts3']['install_dir']}/#{base}"
  end

  service "teamspeak3" do
    pattern "ts3server_linux_amd64"
    action [:enable, :start]
  end
end

log "Set up teamspeak3 server. To get the server admin password and token, check the log." do
  action :nothing
  subscribes :write, resources(:execute => "install_ts3")
end
