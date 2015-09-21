name 'yum-mysql-community'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs/Configures yum-mysql-community'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.18'

depends 'yum', '>= 3.0'

%w(amazon centos fedora oracle redhat scientific).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/yum-mysql-community' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/yum-mysql-community/issues' if respond_to?(:issues_url)
