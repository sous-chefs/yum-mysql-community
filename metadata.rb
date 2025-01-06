name              'yum-mysql-community'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Installs/Configures yum-mysql-community'
version           '5.5.0'
source_url        'https://github.com/sous-chefs/yum-mysql-community'
issues_url        'https://github.com/sous-chefs/yum-mysql-community/issues'
chef_version      '>= 15.3'

depends 'yum', '>= 7.2.0'

supports 'amazon'
supports 'centos'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'scientific'
