#
# Author:: Joshua Timberman <cookbooks@housepub.org>
# Cookbook Name:: teamspeak3
# Attributes:: default
#
# Copyright 2008-2011, Joshua Timberman
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

node.default['ts3']['version'] = "3.0.6.1"
node.default['ts3']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "x86"
node.default['ts3']['url'] = "http://ftp.4players.de/pub/hosted/ts3/releases/#{node['ts3']['version']}/teamspeak3-server_linux-#{node['ts3']['arch']}-#{node['ts3']['version']}.tar.gz"
node.default['ts3']['skip_runit_installation'] = false
