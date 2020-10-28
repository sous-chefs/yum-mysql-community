yum_mysql_community_repo 'mysql community 8.0 repo'

include_recipe 'yum-mysql-community::connectors'

package 'mysql-connector-odbc'
