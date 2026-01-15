default['yum']['mysql80-community']['repositoryid'] = 'mysql80-community'
default['yum']['mysql80-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2023'
default['yum']['mysql80-community']['description'] = 'MySQL 8.0 Community Server'
default['yum']['mysql80-community']['failovermethod'] = 'priority'
default['yum']['mysql80-community']['gpgcheck'] = true
default['yum']['mysql80-community']['enabled'] = true

case node['platform_family']
when 'rhel'
  default['yum']['mysql80-community']['baseurl'] = if platform?('redhat', 'oracle')
                                                     case node['platform_version'].to_i
                                                     when 8
                                                       'https://repo.mysql.com/yum/mysql-8.0-community/el/8/$basearch/'
                                                     else
                                                       # EL 9+ use EL 9 repos (MySQL doesn't have EL 10 repos yet)
                                                       'https://repo.mysql.com/yum/mysql-8.0-community/el/9/$basearch/'
                                                     end
                                                   elsif node['platform_version'].to_i >= 10
                                                     # For other RHEL-family (AlmaLinux, Rocky, CentOS Stream) EL 10+, use EL 9 repos
                                                     'https://repo.mysql.com/yum/mysql-8.0-community/el/9/$basearch/'
                                                   else
                                                     'https://repo.mysql.com/yum/mysql-8.0-community/el/$releasever/$basearch/'
                                                   end
when 'fedora'
  default['yum']['mysql80-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-8.0-community/fc/$releasever/$basearch/'
when 'amazon'
  # Amazon Linux 2023 maps to EL 9
  default['yum']['mysql80-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-8.0-community/el/9/$basearch/'
end
