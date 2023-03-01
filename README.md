# yum-mysql-community Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/yum-mysql-community.svg)](https://supermarket.chef.io/cookbooks/yum-mysql-community)
[![CI State](https://github.com/sous-chefs/yum-mysql-community/workflows/ci/badge.svg)](https://github.com/sous-chefs/yum-mysql-community/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

The yum-mysql-community cookbook takes over management of the default repository ids shipped with mysql*-community-release. It allows attribute manipulation of `mysql-connectors-community`, `mysql56-community`, and `mysql57-community-dmr`.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- RHEL/CentOS and derivatives
- Fedora

### Chef

- Chef 15.3+

### Cookbooks

- `yum` 7.2.0+ (for `dnf_module` resource)

## Attributes

The following attributes are set by default

```ruby
default['yum']['mysql-connectors-community']['repositoryid'] = 'mysql-connectors-community'
default['yum']['mysql-connectors-community']['description'] = 'MySQL Connectors Community'
default['yum']['mysql-connectors-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql-connectors-community/el/$releasever/$basearch/'
default['yum']['mysql-connectors-community']['gpgkey'] = 'https://raw.githubusercontent.com/rs-services/equinix-public/master/cookbooks/db_mysql/files/centos/mysql_pubkey.asc'
default['yum']['mysql-connectors-community']['failovermethod'] = 'priority'
default['yum']['mysql-connectors-community']['gpgcheck'] = true
default['yum']['mysql-connectors-community']['enabled'] = true
```

```ruby
default['yum']['mysql56-community']['repositoryid'] = 'mysql56-community'
default['yum']['mysql56-community']['description'] = 'MySQL 5.6 Community Server'
default['yum']['mysql56-community']['baseurl'] = 'http://repo.mysql.com/yum/mysql56-community/el/$releasever/$basearch/'
default['yum']['mysql56-community']['gpgkey'] = 'https://raw.githubusercontent.com/rs-services/equinix-public/master/cookbooks/db_mysql/files/centos/mysql_pubkey.asc'
default['yum']['mysql56-community']['failovermethod'] = 'priority'
default['yum']['mysql56-community']['gpgcheck'] = true
default['yum']['mysql56-community']['enabled'] = true
```

```ruby
default['yum']['mysql57-community-dmr']['repositoryid'] = 'mysql57-community-dmr'
default['yum']['mysql57-community-dmr']['description'] = 'MySQL 5.7 Community Server Development Milestone Release'
default['yum']['mysql57-community-dmr']['baseurl'] = 'http://repo.mysql.com/yum/mysql56-community/el/$releasever/$basearch/'
default['yum']['mysql57-community-dmr']['gpgkey'] = 'https://raw.githubusercontent.com/rs-services/equinix-public/master/cookbooks/db_mysql/files/centos/mysql_pubkey.asc'
default['yum']['mysql57-community-dmr']['failovermethod'] = 'priority'
default['yum']['mysql57-community-dmr']['gpgcheck'] = true
default['yum']['mysql57-community-dmr']['enabled'] = true
```

## Recipes

- mysql55 - Sets up the mysql55-community repository on supported platforms

```ruby
  yum_repository 'mysql55-community' do
    mirrorlist 'https://repo.mysql.com/yum/mysql-5.5-community/el/$releasever/$basearch/'
    description ''
    enabled true
    gpgcheck true
  end
```

- mysql56 - Sets up the mysql56-community repository on supported platforms

```ruby
  yum_repository 'mysql56-community' do
    mirrorlist 'https://repo.mysql.com/yum/mysql-5.6-community/el/$releasever/$basearch/'
    description ''
    enabled true
    gpgcheck true
  end
```

- connectors - Sets up the mysql-connectors-community repository on supported platforms

## Resources

- yum_mysql_community_repo - Creates /etc/yum.repos.d/mysql-community repo file with enabled repos on supported platforms

```ruby
  yum_mysql_community_repo 'default' do
    version '8.0'
    gpgcheck true
    mysql_community_server true
    mysql_connectors_community true
    mysql_tools_community true
    mysql_tools_preview false
    mysql_cluster_community false
  end
```

## Usage Example

To disable the mysql-community-dmr repository through a Role or Environment definition

```ruby
default_attributes(
  :yum => {
    :mysql57-community-dmr => {
      :enabled => {
        false
       }
     }
   }
 )
```

Uncommonly used repositoryids are not managed by default. This is speeds up integration testing pipelines by avoiding yum-cache builds that nobody cares about. To enable the mysql-community-dmr repository with a wrapper cookbook, place the following in a recipe:

```ruby
node.default['yum']['mysql57-community-dmr']['enabled'] = true
node.default['yum']['mysql57-community-dmr']['managed'] = true
include_recipe 'mysql57-community-dmr'
```

## More Examples

Point the mysql56-community repositories at an internally hosted server.

```ruby
node.default['yum']['mysql56-community']['enabled'] = true
node.default['yum']['mysql56-community']['mirrorlist'] = nil
node.default['yum']['mysql56-community']['baseurl'] = 'https://internal.example.com/mysql/mysql56-community/'
node.default['yum']['mysql56-community']['sslverify'] = false

include_recipe 'mysql56-community'
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
