default['yum']['mysql-connectors-community']['repositoryid'] = 'mysql-connectors-community'
default['yum']['mysql-connectors-community']['gpgkey'] = 'https://raw.githubusercontent.com/chef-cookbooks/yum-mysql-community/master/files/mysql_pubkey.asc'
default['yum']['mysql-connectors-community']['description'] = 'MySQL Connectors Community'
default['yum']['mysql-connectors-community']['failovermethod'] = 'priority'
default['yum']['mysql-connectors-community']['gpgcheck'] = true
default['yum']['mysql-connectors-community']['enabled'] = true

case node['platform_family']
when 'rhel'
  case node['platform']
  when 'redhat', 'oracle' # ~FC024
    case node['platform_version'].to_i
    when 5
      # Real Redhat identifies $releasever as 5Server and 6Server
      default['yum']['mysql-connectors-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-connectors-community/el/5/$basearch/'
    when 6
      default['yum']['mysql-connectors-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-connectors-community/el/6/$basearch/'
    when 7
      default['yum']['mysql-connectors-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-connectors-community/el/7/$basearch/'
    end
  else # other rhel
    default['yum']['mysql-connectors-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-connectors-community/el/$releasever/$basearch/'
  end
when 'fedora'
  default['yum']['mysql-connectors-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-connectors-community/fc/$releasever/$basearch/'
when 'amazon'
  default['yum']['mysql-connectors-community']['baseurl'] = case node['platform_version'].to_i
                                                            when /201./
                                                              'http://repo.mysql.com/yum/mysql-connectors-community/el/6/$basearch/'
                                                            when 2
                                                              'http://repo.mysql.com/yum/mysql-connectors-community/el/7/$basearch/'
                                                            else
                                                              'http://repo.mysql.com/yum/mysql-connectors-community/el/6/$basearch/'
                                                            end
end
