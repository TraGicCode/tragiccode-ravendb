require 'spec_helper'

describe 'ravendb' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default values for all parameters' do
        # it { should compile }
        it { is_expected.to contain_class('ravendb') }
        it { is_expected.to contain_class('ravendb::params') }
        it {
          is_expected.to contain_class('ravendb::install').with(package_ensure: 'present',
                                                                include_management_tools: false,
                                                                ravendb_service_name: 'RavenDB',
                                                                ravendb_port: '8080',
                                                                ravendb_target_environment: 'development',
                                                                ravendb_install_log_absolute_path: 'C:\\RavenDB.install.log',
                                                                ravendb_uninstall_log_absolute_path: 'C:\\RavenDB.uninstall.log',
                                                                ravendb_database_directory: 'C:\\RavenDB\\Databases',
                                                                ravendb_filesystems_database_directory: 'C:\\RavenDB\\FileSystems')
        }
        it {
          is_expected.to contain_class('ravendb::config')
            .that_requires('Class[ravendb::install]')
            .that_notifies('Class[ravendb::service]')
            .with(ravendb_server_exe_config_absolute_path: 'C:\\RavenDB\\Raven.Server.exe.config',
                  ravendb_port: '8080',
                  config: {})
        }
        it {
          is_expected.to contain_class('ravendb::service').with(package_ensure: 'present',
                                                                service_ensure: 'running',
                                                                service_enable: true)
        }
      end

      context 'with service_restart_on_config_change => false' do
        let(:params) do
          {
            service_restart_on_config_change: false,
          }
        end

        it { is_expected.to contain_class('ravendb::config').that_requires('Class[ravendb::install]').that_comes_before('Class[ravendb::service]') }
        it { is_expected.not_to contain_class('ravendb::config').that_notifies('Class[ravendb::service]') }
      end
    end
  end
end
