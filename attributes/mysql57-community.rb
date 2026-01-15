default['yum']['mysql57-community']['repositoryid'] = 'mysql57-community'
default['yum']['mysql57-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2022'
default['yum']['mysql57-community']['description'] = 'MySQL 5.7 Community Server'
default['yum']['mysql57-community']['failovermethod'] = 'priority'
default['yum']['mysql57-community']['gpgcheck'] = true
default['yum']['mysql57-community']['enabled'] = true

case node['platform_family']
when 'rhel'
  default['yum']['mysql57-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-5.7-community/el/$releasever/$basearch/'
when 'fedora'
  default['yum']['mysql57-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-5.7-community/fc/$releasever/$basearch/'
when 'amazon'
  default['yum']['mysql57-community']['baseurl'] =
    case node['platform_version'].to_i
    when /201./
      'https://repo.mysql.com/yum/mysql-5.7-community/el/6/$basearch/'
    when 2
      'https://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/'
    when 2023
      'https://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/'
    else
      'https://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/'
    end
end
