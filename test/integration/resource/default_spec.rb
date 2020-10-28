describe package('mysql-community-server') do
  it { should be_installed }
  its('version') { should match /^8\.0.*/ }
end

describe command 'mysql --version' do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /Ver 8\.0.*/ }
end
