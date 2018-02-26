default['yum']['mysql56-community']['repositoryid'] = 'mysql56-community'
default['yum']['mysql56-community']['gpgkey'] = 'http://repo.mysql.com/RPM-GPG-KEY-mysql'
default['yum']['mysql56-community']['description'] = 'MySQL 5.6 Community Server'
default['yum']['mysql56-community']['failovermethod'] = 'priority'
default['yum']['mysql56-community']['gpgcheck'] = true
default['yum']['mysql56-community']['enabled'] = true

case node['platform_family']
when 'rhel'
  case node['platform']
  when 'redhat', 'oracle' # ~FC024
    case node['platform_version'].to_i
    when 5
      # Real Redhat identifies $releasever as 5Server and 6Server
      default['yum']['mysql56-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.6-community/el/5/$basearch/'
    when 6
      default['yum']['mysql56-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/'
    when 7
      default['yum']['mysql56-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/'
    end
  else # other rhel
    default['yum']['mysql56-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.6-community/el/$releasever/$basearch/'
  end
when 'fedora'
  default['yum']['mysql56-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-5.6-community/fc/$releasever/$basearch/'
when 'amazon'
  default['yum']['mysql56-community']['baseurl'] = case node['platform_version'].to_i
                                                   when /201./
                                                     'http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/'
                                                   when 2
                                                     'http://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/'
                                                   else
                                                     'http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/'
                                                   end
end
