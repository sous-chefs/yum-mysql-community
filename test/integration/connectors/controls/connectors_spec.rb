# frozen_string_literal: true

require_relative '../../spec_helper'

title 'MySQL Connectors Community Repository'

control 'yum-mysql-community-connectors-01' do
  impact 1.0
  title 'Only the connectors repository is enabled'

  describe file(mysql_repo_file('mysql-connectors-community')) do
    it { should exist }
    its('content') { should match /^\[mysql-connectors-community\]/ }
    its('content') { should match /\[mysql-connectors-community\]\nname=MySQL Connectors Community\nbaseurl=.*\nenabled=1/m }
  end

  describe file(mysql_repo_file('mysql-community')) do
    it { should exist }
    its('content') { should match /\[mysql-community\]\nname=MySQL 8\.4 Community Server\nbaseurl=.*\nenabled=0/m }
  end

  describe file(mysql_repo_file('mysql-tools-community')) do
    it { should exist }
    its('content') { should match /\[mysql-tools-community\]\nname=MySQL Tools Community\nbaseurl=.*\nenabled=0/m }
  end
end
