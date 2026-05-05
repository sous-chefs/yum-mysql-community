# frozen_string_literal: true

provides :yum_mysql_community_repo
unified_mode true

description 'Configure yum repo for MySQL Community edition' if respond_to?(:description)

property :version, String,
         equal_to: %w(8.0 8.4 innovation),
         default: '8.4',
         description: 'MySQL release series to configure'

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

property :disable_distro_mysql_module, [true, false],
         default: true,
         description: 'Disable the distro mysql DNF module on EL 8+ platforms'

property :mysql_community_server_repositoryid, String,
         default: 'mysql-community',
         description: 'Repository ID for the MySQL Community Server repository'

property :mysql_connectors_community_repositoryid, String,
         default: 'mysql-connectors-community',
         description: 'Repository ID for the MySQL Connectors Community repository'

property :mysql_tools_community_repositoryid, String,
         default: 'mysql-tools-community',
         description: 'Repository ID for the MySQL Tools Community repository'

property :mysql_tools_preview_repositoryid, String,
         default: 'mysql-tools-preview',
         description: 'Repository ID for the MySQL Tools Preview repository'

property :mysql_cluster_community_repositoryid, String,
         default: 'mysql-cluster-community',
         description: 'Repository ID for the MySQL Cluster Community repository'

property :mysql_community_server_baseurl, [String, nil],
         description: 'Override baseurl for the MySQL Community Server repository'

property :mysql_connectors_community_baseurl, [String, nil],
         description: 'Override baseurl for the MySQL Connectors Community repository'

property :mysql_tools_community_baseurl, [String, nil],
         description: 'Override baseurl for the MySQL Tools Community repository'

property :mysql_tools_preview_baseurl, [String, nil],
         description: 'Override baseurl for the MySQL Tools Preview repository'

property :mysql_cluster_community_baseurl, [String, nil],
         description: 'Override baseurl for the MySQL Cluster Community repository'

property :mysql_community_server_mirrorlist, [String, nil],
         description: 'Override mirrorlist for the MySQL Community Server repository'

property :mysql_connectors_community_mirrorlist, [String, nil],
         description: 'Override mirrorlist for the MySQL Connectors Community repository'

property :mysql_tools_community_mirrorlist, [String, nil],
         description: 'Override mirrorlist for the MySQL Tools Community repository'

property :mysql_tools_preview_mirrorlist, [String, nil],
         description: 'Override mirrorlist for the MySQL Tools Preview repository'

property :mysql_cluster_community_mirrorlist, [String, nil],
         description: 'Override mirrorlist for the MySQL Cluster Community repository'

action :create do
  description 'Create MySQL Community Repo file'

  dnf_module 'mysql' do
    action :disable
    only_if { new_resource.disable_distro_mysql_module && platform_family?('rhel') && platform_major_version >= 8 }
  end

  yum_repository new_resource.mysql_community_server_repositoryid do
    description mysql_community_server_description
    if new_resource.mysql_community_server_mirrorlist
      mirrorlist new_resource.mysql_community_server_mirrorlist
    else
      baseurl(new_resource.mysql_community_server_baseurl || repository_url(mysql_server_repository_path))
    end
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_community_server
    gpgkey new_resource.gpgkey
  end

  yum_repository new_resource.mysql_connectors_community_repositoryid do
    description 'MySQL Connectors Community'
    if new_resource.mysql_connectors_community_mirrorlist
      mirrorlist new_resource.mysql_connectors_community_mirrorlist
    else
      baseurl(new_resource.mysql_connectors_community_baseurl || repository_url('mysql-connectors-community'))
    end
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_connectors_community
    gpgkey new_resource.gpgkey
  end

  yum_repository new_resource.mysql_tools_community_repositoryid do
    description 'MySQL Tools Community'
    if new_resource.mysql_tools_community_mirrorlist
      mirrorlist new_resource.mysql_tools_community_mirrorlist
    else
      baseurl(new_resource.mysql_tools_community_baseurl || repository_url(mysql_tools_repository_path))
    end
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_tools_community
    gpgkey new_resource.gpgkey
  end

  yum_repository new_resource.mysql_tools_preview_repositoryid do
    description 'MySQL Tools Preview'
    if new_resource.mysql_tools_preview_mirrorlist
      mirrorlist new_resource.mysql_tools_preview_mirrorlist
    else
      baseurl(new_resource.mysql_tools_preview_baseurl || repository_url('mysql-tools-preview'))
    end
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_tools_preview
    gpgkey new_resource.gpgkey
  end

  yum_repository new_resource.mysql_cluster_community_repositoryid do
    description "MySQL Cluster #{new_resource.version} Community"
    if new_resource.mysql_cluster_community_mirrorlist
      mirrorlist new_resource.mysql_cluster_community_mirrorlist
    else
      baseurl(new_resource.mysql_cluster_community_baseurl || repository_url(mysql_cluster_repository_path))
    end
    gpgcheck new_resource.gpgcheck
    enabled new_resource.mysql_cluster_community
    gpgkey new_resource.gpgkey
  end
end

action :remove do
  description 'Remove MySQL Community Repo file'

  remove_mysql_repositories
end

action :delete do
  description 'Remove MySQL Community Repo file'

  remove_mysql_repositories
end

action_class do
  def remove_mysql_repositories
    reset_mysql_module
    remove_repository_files
  end

  def reset_mysql_module
    return unless new_resource.disable_distro_mysql_module

    dnf_module 'mysql' do
      action :reset
      only_if { platform_family?('rhel') && platform_major_version >= 8 }
    end
  end

  def remove_repository_files
    [
      new_resource.mysql_community_server_repositoryid,
      new_resource.mysql_connectors_community_repositoryid,
      new_resource.mysql_tools_community_repositoryid,
      new_resource.mysql_tools_preview_repositoryid,
      new_resource.mysql_cluster_community_repositoryid,
    ].each do |repo|
      yum_repository repo do
        action :remove
      end
    end
  end

  def mysql_server_repository_path
    return 'mysql-innovation-community' if new_resource.version == 'innovation'

    "mysql-#{new_resource.version}-community"
  end

  def mysql_tools_repository_path
    case new_resource.version
    when 'innovation'
      'mysql-tools-innovation-community'
    when '8.4'
      'mysql-tools-8.4-community'
    else
      'mysql-tools-community'
    end
  end

  def mysql_cluster_repository_path
    return 'mysql-cluster-innovation-community' if new_resource.version == 'innovation'

    "mysql-cluster-#{new_resource.version}-community"
  end

  def mysql_community_server_description
    return 'MySQL Innovation Community Server' if new_resource.version == 'innovation'

    "MySQL #{new_resource.version} Community Server"
  end

  def repository_url(repository_path)
    "https://repo.mysql.com/yum/#{repository_path}/#{platform_segment}/#{platform_release}/$basearch/"
  end

  def platform_segment
    case node['platform_family']
    when 'rhel'
      'el'
    when 'fedora'
      'fc'
    else
      raise 'Unable to determine OS platform_family.'
    end
  end

  def platform_release
    case node['platform_family']
    when 'rhel'
      platform_major_version.to_s
    when 'fedora'
      '$releasever'
    else
      raise 'Unable to determine OS platform_family.'
    end
  end

  def platform_major_version
    node['platform_version'].to_i
  end
end
