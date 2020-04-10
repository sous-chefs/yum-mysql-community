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

resource_name 'yum_mysql_community_repo'

description 'Configure yum repo for MySQL Community edition' if respond_to?(:description)

property :version, String,
         default: '8.0',
         description: 'MySQL version to configure'

property :gpgcheck, [true, false],
         default: true,
         description: 'Enable or disable GPG checks'

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

  template '/etc/yum.repos.d/mysql-community.repo' do
    cookbook 'yum-mysql-community'
    source 'yum_repo.erb'
    variables(
      temp: {
        version: new_resource.version,
        gpgcheck: one_or_zero(new_resource.gpgcheck),
        os: os,
        os_ver: os_ver,
        mysql_community_server: one_or_zero(new_resource.mysql_community_server),
        mysql_connectors_community: one_or_zero(new_resource.mysql_connectors_community),
        mysql_tools_community: one_or_zero(new_resource.mysql_tools_community),
        mysql_tools_preview: one_or_zero(new_resource.mysql_tools_preview),
        mysql_cluster_community: one_or_zero(new_resource.mysql_cluster_community),
      }
    )
  end
end

action :delete do
  description 'Remove MySQL Community Repo file'

  template '/etc/yum.repos.d/mysql-community.repo' do
    action :delete
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
        node['platform_version'].to_i
      else
        '$releasever'
      end
    when 'amazon'
      case node['platform_version'].to_i
      when /201./
        '6'
      when 2
        '7'
      when 3
        '8'
      else
        '7'
      end
    else
      raise 'Unable to determine OS platform_family.'
    end
  end
end
