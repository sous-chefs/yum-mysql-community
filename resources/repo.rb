# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
#
# Author:: Corey Hemminger (<hemminger@hotmail.com>)
# Cookbook:: yum-mysql-community
# Resource:: repo
#
# Copyright:: 2020, Chef Software, Inc.
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

resource_name :yum_mysql_community_repo
provides :yum_mysql_community_repo
unified_mode true

description 'Configure yum repo for MySQL Community edition' if respond_to?(:description)

property :version, String,
         default: '8.0',
         description: 'MySQL version to configure'

property :gpgcheck, [true, false],
         default: true,
         description: 'Enable or disable GPG checks'

property :gpgkey, [String, Array],
         default: 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2025',
         description: 'GPG key(s)'

property :mysql_community_server, [true, false],
         default: true,
         description: 'Enable or disable mysql community server repo'

property :mysql_connectors_community, [true, false],
         default: true,
         description: 'Enable or disable mysql connectors community repo'

property :mysql_tools_community, [true, false],
         default: true,
         description: 'Enable or disable mysql tools community repo'

property :mysql_tools_preview, [true, false],
         default: false,
         description: 'Enable or disable mysql tools repo'

property :mysql_cluster_community, [true, false],
         default: false,
         description: 'Enable or disable GPG checks mysql cluster community repo'

action :create do
  description 'Create MySQL Community Repo file'

  dnf_module 'mysql' do
    action :disable
    only_if { platform_family?('rhel') && node['platform_version'].to_i.between?(8, 9) }
  end

  yum_repository 'mysql-community' do
    description "MySQL #{new_resource.version} Community Server"
    baseurl "https://repo.mysql.com/yum/mysql-#{new_resource.version}-community/#{os}/#{os_ver}/$basearch/"
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_community_server
    gpgkey new_resource.gpgkey
  end

  yum_repository 'mysql-connectors-community' do
    description 'MySQL Connectors Community'
    baseurl "https://repo.mysql.com/yum/mysql-connectors-community/#{os}/#{os_ver}/$basearch/"
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_connectors_community
    gpgkey new_resource.gpgkey
  end

  yum_repository 'mysql-tools-community' do
    description 'MySQL Tools Community'
    if new_resource.version.to_f < 8.4
      baseurl "https://repo.mysql.com/yum/mysql-tools-community/#{os}/#{os_ver}/$basearch/"
    else
      baseurl "https://repo.mysql.com/yum/mysql-tools-#{new_resource.version}-community/#{os}/#{os_ver}/$basearch/"
    end
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_tools_community
    gpgkey new_resource.gpgkey
  end

  yum_repository 'mysql-tools-preview' do
    description 'MySQL Tools Preview'
    baseurl "https://repo.mysql.com/yum/mysql-tools-preview/#{os}/#{os_ver}/$basearch/"
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_tools_preview
    gpgkey new_resource.gpgkey
  end

  yum_repository 'mysql-cluster-community' do
    description "MySQL Cluster #{new_resource.version} Community"
    baseurl "https://repo.mysql.com/yum/mysql-cluster-#{new_resource.version}-community/#{os}/#{os_ver}/$basearch/"
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_cluster_community
    gpgkey new_resource.gpgkey
  end
end

action :delete do
  description 'Remove MySQL Community Repo file'

  %w(
    mysql-community
    mysql-connectors-community
    mysql-tools-community
    mysql-tools-preview
    mysql-cluster-community
  ).each do |r|
    yum_repository r do
      action :remove
    end
  end
end

action_class do
  def one_or_zero(bool)
    bool ? 1 : 0
  end

  def os
    case node['platform_family']
    when 'amazon', 'rhel'
      'el'
    when 'fedora'
      'fc'
    else
      raise 'Unable to determine OS platform_family.'
    end
  end

  def os_ver
    case node['platform_family']
    when 'fedora', 'rhel'
      if platform?('redhat', 'oracle')
        # MySQL repos only support up to EL 9, use 9 for EL 10+
        [node['platform_version'].to_i, 9].min
      elsif node['platform_version'].to_i >= 10
        # For other RHEL-family distros, cap at 9 for EL 10+
        '9'
      else
        '$releasever'
      end
    when 'amazon'
      # Amazon Linux 2023 maps to EL 9
      '9'
    else
      raise 'Unable to determine OS platform_family.'
    end
  end
end
