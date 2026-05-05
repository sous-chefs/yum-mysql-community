# Migration Guide

This release is a full custom resource migration. The cookbook no longer ships `recipes/` or `attributes/`.

## Breaking Changes

* Removed `yum-mysql-community::connectors`.
* Removed `yum-mysql-community::mysql55`.
* Removed `yum-mysql-community::mysql56`.
* Removed `yum-mysql-community::mysql57`.
* Removed all `node['yum']['mysql-*']` attribute APIs.
* Removed MySQL 5.5, 5.6, and 5.7 repository support.
* Changed the custom resource default MySQL series from `8.0` to `8.4`.
* Removed Amazon Linux, CentOS Linux 7, CentOS Stream 8, and Scientific Linux platform support.

## Why MySQL 5.x Was Removed

Oracle's current MySQL Yum Repository guide supports MySQL 8.0, MySQL 8.4 LTS, and the MySQL Innovation series. It explicitly states that MySQL 5.7 is not supported, and the upstream 5.5, 5.6, and 5.7 repository directories are stale. Encoding those repository defaults would preserve dead APIs rather than working behavior on current non-EOL platforms.

## Replacing Recipes

### Before

```ruby
include_recipe 'yum-mysql-community::connectors'
```

### After

```ruby
yum_mysql_community_repo 'mysql connectors repo' do
  mysql_community_server false
  mysql_connectors_community true
  mysql_tools_community false
  mysql_tools_preview false
  mysql_cluster_community false
end
```

### Before

```ruby
include_recipe 'yum-mysql-community::mysql57'
```

### After

MySQL 5.7 is not supported. Use a supported MySQL series:

```ruby
yum_mysql_community_repo 'mysql community repo' do
  version '8.4'
end
```

## Replacing Node Attributes

### Before

```ruby
node.default['yum']['mysql56-community']['baseurl'] = 'https://internal.example.com/mysql/mysql56-community/'
node.default['yum']['mysql56-community']['sslverify'] = false

include_recipe 'yum-mysql-community::mysql56'
```

### After

```ruby
yum_mysql_community_repo 'internal mysql repo' do
  version '8.4'
  mysql_community_server_baseurl 'https://internal.example.com/mysql/mysql-8.4-community/'
  gpgkey 'https://internal.example.com/mysql/RPM-GPG-KEY-mysql'
end
```

## Test Cookbook Examples

The migration examples used by Kitchen live in:

* `test/cookbooks/test/recipes/default.rb`
* `test/cookbooks/test/recipes/mysql80.rb`
* `test/cookbooks/test/recipes/connectors.rb`
* `test/cookbooks/test/recipes/innovation.rb`
