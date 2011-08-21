#
# Author:: Joshua Timberman <cookbooks@housepub.org>
# Cookbook Name:: teamspeak3
# Recipe:: default
#
# Copyright 2011, Joshua Timberman
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

case node['platform']
when 'mac_os_x'
  
  dmg_package "TeamSpeak 3 Client" do
    volumes_dir "Teamspeak 3 Client"
    dmg_name "TeamSpeak3"
    source "http://ftp.4players.de/pub/hosted/ts3/releases/3.0.0/TeamSpeak3-Client-macosx-3.0.0.dmg"
    checksum "e171a4ca15f2d94515557ae690e02484d071fc4154427583494a5768f989fcb3"
  end
else
  return "Platform #{node['platform']} is not supported yet for Teamspeak client installation."
end
