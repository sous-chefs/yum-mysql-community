# frozen_string_literal: true

name              'yum-mysql-community'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Configures Oracle MySQL Community Yum repositories'
version           '5.5.3'
source_url        'https://github.com/sous-chefs/yum-mysql-community'
issues_url        'https://github.com/sous-chefs/yum-mysql-community/issues'
chef_version      '>= 15.3'

depends 'yum', '>= 7.2.0'

supports 'almalinux', '>= 8.0'
supports 'centos_stream', '>= 9.0'
supports 'fedora'
supports 'oracle', '>= 8.0'
supports 'redhat', '>= 8.0'
supports 'rocky', '>= 8.0'
