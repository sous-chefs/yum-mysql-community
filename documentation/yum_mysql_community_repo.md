# yum_mysql_community_repo

Configures Oracle MySQL Community Yum repositories.

## Actions

| Action    | Description                                    |
|-----------|------------------------------------------------|
| `:create` | Creates the repository files. Default action.  |
| `:remove` | Removes the repository files and resets module |
| `:delete` | Alias for `:remove`.                           |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `version` | String | `'8.4'` | MySQL series: `8.0`, `8.4`, or `innovation`. |
| `gpgcheck` | true, false | `true` | Enables GPG checks. |
| `gpgkey` | String, Array | `'https://repo.mysql.com/RPM-GPG-KEY-mysql-2025'` | GPG key URL or URLs. |
| `mysql_community_server` | true, false | `true` | Enables the server repository. |
| `mysql_connectors_community` | true, false | `true` | Enables the connectors repository. |
| `mysql_tools_community` | true, false | `true` | Enables the tools repository. |
| `mysql_tools_preview` | true, false | `false` | Enables the tools preview repository. |
| `mysql_cluster_community` | true, false | `false` | Enables the cluster repository. |
| `disable_distro_mysql_module` | true, false | `true` | Disables the distro `mysql` DNF module on EL 8+. |
| `mysql_community_server_repositoryid` | String | `'mysql-community'` | Server repository ID. |
| `mysql_connectors_community_repositoryid` | String | `'mysql-connectors-community'` | Connectors repository ID. |
| `mysql_tools_community_repositoryid` | String | `'mysql-tools-community'` | Tools repository ID. |
| `mysql_tools_preview_repositoryid` | String | `'mysql-tools-preview'` | Tools preview repository ID. |
| `mysql_cluster_community_repositoryid` | String | `'mysql-cluster-community'` | Cluster repository ID. |
| `mysql_community_server_baseurl` | String, nil | computed | Server repository base URL override. |
| `mysql_connectors_community_baseurl` | String, nil | computed | Connectors repository base URL override. |
| `mysql_tools_community_baseurl` | String, nil | computed | Tools repository base URL override. |
| `mysql_tools_preview_baseurl` | String, nil | computed | Tools preview repository base URL override. |
| `mysql_cluster_community_baseurl` | String, nil | computed | Cluster repository base URL override. |
| `mysql_community_server_mirrorlist` | String, nil | `nil` | Server repository mirrorlist override. |
| `mysql_connectors_community_mirrorlist` | String, nil | `nil` | Connectors repository mirrorlist override. |
| `mysql_tools_community_mirrorlist` | String, nil | `nil` | Tools repository mirrorlist override. |
| `mysql_tools_preview_mirrorlist` | String, nil | `nil` | Tools preview repository mirrorlist override. |
| `mysql_cluster_community_mirrorlist` | String, nil | `nil` | Cluster repository mirrorlist override. |

## Examples

### MySQL 8.4 LTS

```ruby
yum_mysql_community_repo 'mysql community repo'
```

### MySQL 8.0

```ruby
yum_mysql_community_repo 'mysql community 8.0 repo' do
  version '8.0'
end
```

### MySQL Innovation

```ruby
yum_mysql_community_repo 'mysql innovation repo' do
  version 'innovation'
end
```

### Connectors Only

```ruby
yum_mysql_community_repo 'mysql connectors repo' do
  mysql_community_server false
  mysql_connectors_community true
  mysql_tools_community false
  mysql_tools_preview false
  mysql_cluster_community false
end
```

### Internal Mirror

```ruby
yum_mysql_community_repo 'internal mysql repo' do
  mysql_community_server_baseurl 'https://internal.example.com/mysql/mysql-8.4-community/'
  mysql_connectors_community_baseurl 'https://internal.example.com/mysql/mysql-connectors-community/'
  gpgkey 'https://internal.example.com/mysql/RPM-GPG-KEY-mysql'
end
```
