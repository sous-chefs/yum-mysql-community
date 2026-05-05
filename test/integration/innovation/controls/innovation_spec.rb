# frozen_string_literal: true

require_relative '../../spec_helper'

title 'MySQL Innovation Community Repository'

control 'yum-mysql-community-innovation-01' do
  impact 1.0
  title 'MySQL Innovation repositories are configured'

  describe file(mysql_repo_file('mysql-community')) do
    it { should exist }
    its('content') { should match /^\[mysql-community\]/ }
    its('content') { should match %r{mysql-innovation-community/el/} }
  end

  describe file(mysql_repo_file('mysql-tools-community')) do
    it { should exist }
    its('content') { should match %r{mysql-tools-innovation-community/el/} }
  end
end
