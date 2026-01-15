default['yum']['mysql-connectors-community']['repositoryid'] = 'mysql-connectors-community'
default['yum']['mysql-connectors-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2023'
default['yum']['mysql-connectors-community']['description'] = 'MySQL Connectors Community'
default['yum']['mysql-connectors-community']['gpgcheck'] = true
default['yum']['mysql-connectors-community']['enabled'] = true

case node['platform_family']
when 'rhel'
  default['yum']['mysql-connectors-community']['baseurl'] = if platform?('redhat', 'oracle')
                                                               case node['platform_version'].to_i
                                                               when 8
                                                                 'https://repo.mysql.com/yum/mysql-connectors-community/el/8/$basearch/'
                                                               else
                                                                 # EL 9+ use EL 9 repos (MySQL doesn't have EL 10 repos yet)
                                                                 'https://repo.mysql.com/yum/mysql-connectors-community/el/9/$basearch/'
                                                               end
                                                             elsif node['platform_version'].to_i >= 10
                                                               # For other RHEL-family (AlmaLinux, Rocky, CentOS Stream) EL 10+, use EL 9 repos
                                                               'https://repo.mysql.com/yum/mysql-connectors-community/el/9/$basearch/'
                                                             else
                                                               'https://repo.mysql.com/yum/mysql-connectors-community/el/$releasever/$basearch/'
                                                             end
when 'fedora'
  default['yum']['mysql-connectors-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-connectors-community/fc/$releasever/$basearch/'
when 'amazon'
  # Amazon Linux 2023 maps to EL 9
  default['yum']['mysql-connectors-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-connectors-community/el/9/$basearch/'
end
