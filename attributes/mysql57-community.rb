default['yum']['mysql57-community']['repositoryid'] = 'mysql57-community'
default['yum']['mysql57-community']['gpgkey'] = 'http://repo.mysql.com/RPM-GPG-KEY-mysql'
default['yum']['mysql57-community']['description'] = 'MySQL 5.7 Community Server'
default['yum']['mysql57-community']['failovermethod'] = 'priority'
default['yum']['mysql57-community']['gpgcheck'] = true
default['yum']['mysql57-community']['enabled'] = true

case node['platform_family']
when 'rhel'
  case node['platform']
  when 'redhat', 'oracle' # ~FC024
    case node['platform_version'].to_i
    when 5
      # Real Redhat identifies $releasever as 5Server and 6Server
      default['yum']['mysql57-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.7-community/el/5/$basearch/'
    when 6
      default['yum']['mysql57-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.7-community/el/6/$basearch/'
    when 7
      default['yum']['mysql57-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/'
    end
  else # other rhel
    default['yum']['mysql57-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.7-community/el/$releasever/$basearch/'
  end
when 'fedora'
  default['yum']['mysql57-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.7-community/fc/$releasever/$basearch/'
when 'amazon'
  default['yum']['mysql57-community']['baseurl'] = case node['platform_version'].to_i
                                                   when /201./
                                                     'http://repo.mysql.com/yum/mysql-5.7-community/el/6/$basearch/'
                                                   when 2
                                                     'http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/'
                                                   else
                                                     'http://repo.mysql.com/yum/mysql-5.7-community/el/6/$basearch/'
                                                   end
end
