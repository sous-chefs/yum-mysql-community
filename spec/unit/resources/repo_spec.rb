# frozen_string_literal: true

require 'spec_helper'

describe 'yum_mysql_community_repo' do
  step_into :yum_mysql_community_repo
  platform 'oracle', '9'

  let(:dnf_mysql_module_list) { double(exitstatus: 0, stdout: "mysql 8.0 common [d]\n") }

  before do
    stubs_for_provider('yum_mysql_community_repo[mysql community repo]') do |provider|
      allow(provider).to receive_shell_out('dnf -q module list mysql').and_return(dnf_mysql_module_list)
    end
  end

  context 'with default properties' do
    recipe do
      yum_mysql_community_repo 'mysql community repo'
    end

    it { is_expected.to disable_dnf_module('mysql') }

    it do
      is_expected.to create_yum_repository('mysql-community').with(
        description: 'MySQL 8.4 Community Server',
        baseurl: 'https://repo.mysql.com/yum/mysql-8.4-community/el/9/$basearch/',
        enabled: true,
        gpgcheck: true,
        gpgkey: 'https://repo.mysql.com/RPM-GPG-KEY-mysql-2025'
      )
    end

    it do
      is_expected.to create_yum_repository('mysql-connectors-community').with(
        baseurl: 'https://repo.mysql.com/yum/mysql-connectors-community/el/9/$basearch/',
        enabled: true
      )
    end

    it do
      is_expected.to create_yum_repository('mysql-tools-community').with(
        baseurl: 'https://repo.mysql.com/yum/mysql-tools-8.4-community/el/9/$basearch/',
        enabled: true
      )
    end

    it { is_expected.to create_yum_repository('mysql-tools-preview').with(enabled: false) }
    it { is_expected.to create_yum_repository('mysql-cluster-community').with(enabled: false) }
  end

  context 'with MySQL 8.0' do
    recipe do
      yum_mysql_community_repo 'mysql community repo' do
        version '8.0'
      end
    end

    it do
      is_expected.to create_yum_repository('mysql-community').with(
        description: 'MySQL 8.0 Community Server',
        baseurl: 'https://repo.mysql.com/yum/mysql-8.0-community/el/9/$basearch/'
      )
    end

    it do
      is_expected.to create_yum_repository('mysql-tools-community').with(
        baseurl: 'https://repo.mysql.com/yum/mysql-tools-community/el/9/$basearch/'
      )
    end
  end

  context 'with MySQL Innovation' do
    recipe do
      yum_mysql_community_repo 'mysql community repo' do
        version 'innovation'
      end
    end

    it do
      is_expected.to create_yum_repository('mysql-community').with(
        description: 'MySQL Innovation Community Server',
        baseurl: 'https://repo.mysql.com/yum/mysql-innovation-community/el/9/$basearch/'
      )
    end

    it do
      is_expected.to create_yum_repository('mysql-tools-community').with(
        baseurl: 'https://repo.mysql.com/yum/mysql-tools-innovation-community/el/9/$basearch/'
      )
    end
  end

  context 'with custom repository options' do
    recipe do
      yum_mysql_community_repo 'mysql community repo' do
        mysql_community_server_repositoryid 'internal-mysql'
        mysql_community_server_baseurl 'https://repo.example.test/mysql/'
        mysql_connectors_community_mirrorlist 'https://repo.example.test/connectors.mirror'
        mysql_tools_community false
        gpgcheck false
        gpgkey %w(https://repo.example.test/key.asc)
      end
    end

    it do
      is_expected.to create_yum_repository('internal-mysql').with(
        baseurl: 'https://repo.example.test/mysql/',
        gpgcheck: false,
        gpgkey: ['https://repo.example.test/key.asc']
      )
    end

    it do
      is_expected.to create_yum_repository('mysql-connectors-community').with(
        mirrorlist: 'https://repo.example.test/connectors.mirror'
      )
    end

    it { is_expected.to create_yum_repository('mysql-tools-community').with(enabled: false) }
  end

  context 'with action remove' do
    recipe do
      yum_mysql_community_repo 'mysql community repo' do
        action :remove
      end
    end

    it { is_expected.to reset_dnf_module('mysql') }
    it { is_expected.to remove_yum_repository('mysql-community') }
    it { is_expected.to remove_yum_repository('mysql-connectors-community') }
    it { is_expected.to remove_yum_repository('mysql-tools-community') }
    it { is_expected.to remove_yum_repository('mysql-tools-preview') }
    it { is_expected.to remove_yum_repository('mysql-cluster-community') }
  end

  context 'when the distro mysql module is absent' do
    platform 'almalinux', '10'

    let(:dnf_mysql_module_list) { double(exitstatus: 0, stdout: '') }

    recipe do
      yum_mysql_community_repo 'mysql community repo'
    end

    it { is_expected.not_to disable_dnf_module('mysql') }
    it { is_expected.to create_yum_repository('mysql-community') }
  end
end
