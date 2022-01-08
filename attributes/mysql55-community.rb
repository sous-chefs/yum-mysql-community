default['yum']['mysql55-community']['repositoryid'] = 'mysql55-community'
default['yum']['mysql55-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql'
default['yum']['mysql55-community']['description'] = 'MySQL 5.5 Community Server'
default['yum']['mysql55-community']['failovermethod'] = 'priority'
default['yum']['mysql55-community']['gpgcheck'] = true
default['yum']['mysql55-community']['enabled'] = true

case node['platform_family']
when 'rhel'
  default['yum']['mysql55-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-5.5-community/el/$releasever/$basearch/'
when 'fedora'
  default['yum']['mysql55-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-5.5-community/el/7/$basearch/'
when 'amazon'
  default['yum']['mysql55-community']['baseurl'] =
    case node['platform_version'].to_i
    when /201./
      'https://repo.mysql.com/yum/mysql-5.5-community/el/6/$basearch/'
    when 2
      'https://repo.mysql.com/yum/mysql-5.5-community/el/7/$basearch/'
    else
      'https://repo.mysql.com/yum/mysql-5.5-community/el/6/$basearch/'
    end
end
