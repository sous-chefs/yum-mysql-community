# frozen_string_literal: true

require_relative '../../spec_helper'

title 'MySQL 8.0 Community Repository'

control 'yum-mysql-community-mysql80-01' do
  impact 1.0
  title 'MySQL 8.0 repositories are configured'

  describe file(mysql_repo_file('mysql-community')) do
    it { should exist }
    its('content') { should match /^\[mysql-community\]/ }
    its('content') { should match %r{mysql-8\.0-community/el/} }
  end

  describe file(mysql_repo_file('mysql-tools-community')) do
    it { should exist }
    its('content') { should match %r{mysql-tools-community/el/} }
  end
end
