# yum-mysql-community Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/yum-mysql-community.svg)](https://supermarket.chef.io/cookbooks/yum-mysql-community)
[![CI State](https://github.com/sous-chefs/yum-mysql-community/workflows/ci/badge.svg)](https://github.com/sous-chefs/yum-mysql-community/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

The yum-mysql-community cookbook takes over management of the default repository ids shipped with mysql*-community-release. It allows attribute manipulation of `mysql-connectors-community`, `mysql80-community`, `mysql84-community`, and legacy versions.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- RHEL 8+, AlmaLinux 8+, Rocky Linux 8+, CentOS Stream 9+
- Amazon Linux 2023
- Fedora

### Chef

- Chef 15.3+

### Cookbooks

- `yum` 7.2.0+ (for `dnf_module` resource)

## Attributes

The following attributes are set by default

### MySQL 8.4 LTS (Recommended)

```ruby
default['yum']['mysql84-community']['repositoryid'] = 'mysql84-community'
default['yum']['mysql84-community']['description'] = 'MySQL 8.4 LTS Community Server'
default['yum']['mysql84-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-8.4-lts-community/el/$releasever/$basearch/'
default['yum']['mysql84-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2023'
default['yum']['mysql84-community']['failovermethod'] = 'priority'
default['yum']['mysql84-community']['gpgcheck'] = true
default['yum']['mysql84-community']['enabled'] = true
```

### MySQL 8.0

```ruby
default['yum']['mysql80-community']['repositoryid'] = 'mysql80-community'
default['yum']['mysql80-community']['description'] = 'MySQL 8.0 Community Server'
default['yum']['mysql80-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-8.0-community/el/$releasever/$basearch/'
default['yum']['mysql80-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2023'
default['yum']['mysql80-community']['failovermethod'] = 'priority'
default['yum']['mysql80-community']['gpgcheck'] = true
default['yum']['mysql80-community']['enabled'] = true
```

### MySQL Connectors

```ruby
default['yum']['mysql-connectors-community']['repositoryid'] = 'mysql-connectors-community'
default['yum']['mysql-connectors-community']['description'] = 'MySQL Connectors Community'
default['yum']['mysql-connectors-community']['baseurl'] = 'https://repo.mysql.com/yum/mysql-connectors-community/el/$releasever/$basearch/'
default['yum']['mysql-connectors-community']['gpgkey'] = 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2023'
default['yum']['mysql-connectors-community']['gpgcheck'] = true
default['yum']['mysql-connectors-community']['enabled'] = true
```

## Recipes

- **mysql84** - Sets up the mysql84-community repository (MySQL 8.4 LTS - recommended)
- **mysql80** - Sets up the mysql80-community repository (MySQL 8.0)
- **connectors** - Sets up the mysql-connectors-community repository

### Legacy Recipes (EOL MySQL versions, limited platform support)

- **mysql57** - Sets up the mysql57-community repository (EOL, EL 7 and Fedora only)
- **mysql56** - Sets up the mysql56-community repository (EOL, EL 7 and Fedora only)
- **mysql55** - Sets up the mysql55-community repository (EOL, EL 7 and Fedora only)

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

## Usage Examples

### Using the resource (recommended)

```ruby
yum_mysql_community_repo 'default' do
  version '8.4'
end

package 'mysql-community-server'
```

### Using recipes

```ruby
include_recipe 'yum-mysql-community::mysql84'

package 'mysql-community-server'
```

### Point repositories at an internally hosted server

```ruby
node.default['yum']['mysql84-community']['enabled'] = true
node.default['yum']['mysql84-community']['mirrorlist'] = nil
node.default['yum']['mysql84-community']['baseurl'] = 'https://internal.example.com/mysql/mysql84-community/'
node.default['yum']['mysql84-community']['sslverify'] = false

include_recipe 'yum-mysql-community::mysql84'
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
