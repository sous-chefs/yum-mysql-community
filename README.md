# yum-mysql-community Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/yum-mysql-community.svg)](https://supermarket.chef.io/cookbooks/yum-mysql-community)
[![CI State](https://github.com/sous-chefs/yum-mysql-community/workflows/ci/badge.svg)](https://github.com/sous-chefs/yum-mysql-community/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

The yum-mysql-community cookbook configures Oracle MySQL Community Yum repositories with a custom resource API.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you'd like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

* AlmaLinux 8+
* CentOS Stream 9+
* Fedora
* Oracle Linux 8+
* Red Hat Enterprise Linux 8+
* Rocky Linux 8+

See [AGENTS.md](AGENTS.md) for vendor support details and unsupported legacy MySQL series.

### Chef

* Chef 15.3+

### Cookbooks

* `yum` 7.2.0+ for the `dnf_module` resource

## Resources

* [yum_mysql_community_repo](documentation/yum_mysql_community_repo.md)

## Usage

Configure the default MySQL 8.4 LTS repositories:

```ruby
yum_mysql_community_repo 'mysql community repo'
```

Configure MySQL 8.0 repositories:

```ruby
yum_mysql_community_repo 'mysql community 8.0 repo' do
  version '8.0'
end
```

Configure only the connectors repository:

```ruby
yum_mysql_community_repo 'mysql connectors repo' do
  mysql_community_server false
  mysql_connectors_community true
  mysql_tools_community false
  mysql_tools_preview false
  mysql_cluster_community false
end
```

Point the server repository at an internally hosted mirror:

```ruby
yum_mysql_community_repo 'internal mysql repo' do
  mysql_community_server_baseurl 'https://internal.example.com/mysql/mysql-8.4-community/'
  gpgkey 'https://internal.example.com/mysql/RPM-GPG-KEY-mysql'
end
```

## Migration

This cookbook no longer provides recipes or node attributes. See [migration.md](migration.md) for the breaking changes and replacement resource examples.

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
