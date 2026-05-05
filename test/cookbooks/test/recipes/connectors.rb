# frozen_string_literal: true

yum_mysql_community_repo 'mysql connectors repo' do
  mysql_community_server false
  mysql_connectors_community true
  mysql_tools_community false
  mysql_tools_preview false
  mysql_cluster_community false
end
