# frozen_string_literal: true

require_relative '../../spec_helper'

title 'Default MySQL Community Repository'

control 'yum-mysql-community-default-01' do
  impact 1.0
  title 'MySQL 8.4 repositories are configured'

  describe file(mysql_repo_file('mysql-community')) do
    it { should exist }
    its('content') { should match /^\[mysql-community\]/ }
    its('content') { should match %r{mysql-8\.4-community/#{mysql_platform_segment}/} }
  end

  describe file(mysql_repo_file('mysql-connectors-community')) do
    it { should exist }
    its('content') { should match /^\[mysql-connectors-community\]/ }
  end

  describe file(mysql_repo_file('mysql-tools-community')) do
    it { should exist }
    its('content') { should match /^\[mysql-tools-community\]/ }
    its('content') { should match %r{mysql-tools-8\.4-community/#{mysql_platform_segment}/} }
  end
end
