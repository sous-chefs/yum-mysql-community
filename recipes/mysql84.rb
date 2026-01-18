#
# Author:: Sous Chefs
# Recipe:: yum-mysql-community::mysql84
#
# Copyright:: 2024, Sous Chefs
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

# Disable the mysql dnf module on EL8/EL9 to allow MySQL Community packages
dnf_module 'mysql' do
  action :disable
  only_if { platform_family?('rhel') && node['platform_version'].to_i.between?(8, 9) }
end

yum_repository 'mysql84-community' do
  description node['yum']['mysql84-community']['description'] unless node['yum']['mysql84-community']['description'].nil?
  baseurl node['yum']['mysql84-community']['baseurl'] unless node['yum']['mysql84-community']['baseurl'].nil?
  mirrorlist node['yum']['mysql84-community']['mirrorlist'] unless node['yum']['mysql84-community']['mirrorlist'].nil?
  gpgcheck node['yum']['mysql84-community']['gpgcheck'] unless node['yum']['mysql84-community']['gpgcheck'].nil?
  gpgkey node['yum']['mysql84-community']['gpgkey'] unless node['yum']['mysql84-community']['gpgkey'].nil?
  enabled node['yum']['mysql84-community']['enabled'] unless node['yum']['mysql84-community']['enabled'].nil?
  cost node['yum']['mysql84-community']['cost'] unless node['yum']['mysql84-community']['cost'].nil?
  exclude node['yum']['mysql84-community']['exclude'] unless node['yum']['mysql84-community']['exclude'].nil?
  enablegroups node['yum']['mysql84-community']['enablegroups'] unless node['yum']['mysql84-community']['enablegroups'].nil?
  failovermethod node['yum']['mysql84-community']['failovermethod'] unless node['yum']['mysql84-community']['failovermethod'].nil?
  http_caching node['yum']['mysql84-community']['http_caching'] unless node['yum']['mysql84-community']['http_caching'].nil?
  include_config node['yum']['mysql84-community']['include_config'] unless node['yum']['mysql84-community']['include_config'].nil?
  includepkgs node['yum']['mysql84-community']['includepkgs'] unless node['yum']['mysql84-community']['includepkgs'].nil?
  keepalive node['yum']['mysql84-community']['keepalive'] unless node['yum']['mysql84-community']['keepalive'].nil?
  max_retries node['yum']['mysql84-community']['max_retries'] unless node['yum']['mysql84-community']['max_retries'].nil?
  metadata_expire node['yum']['mysql84-community']['metadata_expire'] unless node['yum']['mysql84-community']['metadata_expire'].nil?
  mirror_expire node['yum']['mysql84-community']['mirror_expire'] unless node['yum']['mysql84-community']['mirror_expire'].nil?
  priority node['yum']['mysql84-community']['priority'] unless node['yum']['mysql84-community']['priority'].nil?
  proxy node['yum']['mysql84-community']['proxy'] unless node['yum']['mysql84-community']['proxy'].nil?
  proxy_username node['yum']['mysql84-community']['proxy_username'] unless node['yum']['mysql84-community']['proxy_username'].nil?
  proxy_password node['yum']['mysql84-community']['proxy_password'] unless node['yum']['mysql84-community']['proxy_password'].nil?
  repositoryid node['yum']['mysql84-community']['repositoryid'] unless node['yum']['mysql84-community']['repositoryid'].nil?
  sslcacert node['yum']['mysql84-community']['sslcacert'] unless node['yum']['mysql84-community']['sslcacert'].nil?
  sslclientcert node['yum']['mysql84-community']['sslclientcert'] unless node['yum']['mysql84-community']['sslclientcert'].nil?
  sslclientkey node['yum']['mysql84-community']['sslclientkey'] unless node['yum']['mysql84-community']['sslclientkey'].nil?
  sslverify node['yum']['mysql84-community']['sslverify'] unless node['yum']['mysql84-community']['sslverify'].nil?
  timeout node['yum']['mysql84-community']['timeout'] unless node['yum']['mysql84-community']['timeout'].nil?
  action :create
end
