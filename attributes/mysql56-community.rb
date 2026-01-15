default['yum']['mysql56-community']['repositoryid'] = 'mysql56-community'
default['yum']['mysql56-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql'
default['yum']['mysql56-community']['description'] = 'MySQL 5.6 Community Server'
default['yum']['mysql56-community']['failovermethod'] = 'priority'
default['yum']['mysql56-community']['gpgcheck'] = true
default['yum']['mysql56-community']['enabled'] = true

# MySQL 5.6 is EOL and only has repos up to EL 7
# Only supported on EL 7 and Fedora
case node['platform_family']
when 'rhel'
  default['yum']['mysql56-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-5.6-community/el/$releasever/$basearch/'
when 'fedora'
  default['yum']['mysql56-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/'
end
