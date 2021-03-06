require 'spec_helper'
describe 'ravendb::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default values for all parameters' do
        it { is_expected.to contain_class('ravendb::install') }
        it { is_expected.to contain_class('ravendb::params') }

        it {
          is_expected.to contain_file('C:\\RavenDB-3.5.4.Setup.exe')
            .with(ensure: 'file',
                  source: 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.4.Setup.exe')
        }

        it {
          is_expected.to contain_package('RavenDB')
            .with(ensure: 'present',
                  source: 'C:\\RavenDB-3.5.4.Setup.exe',
                  install_options: [
                    '/quiet',
                    '/log',
                    'C:\\RavenDB.install.log',
                    '/msicl',
                    '"',
                    'RAVEN_TARGET_ENVIRONMENT=development',
                    'RAVEN_WORKING_DIR=~\\',
                    'INSTALLFOLDER=C:\\RavenDB',
                    'RAVEN_DATA_DIR=C:\\RavenDB\\Databases',
                    'RAVENFS_DATA_DIR=C:\\RavenDB\\FileSystems',
                    'RAVEN_INSTALLATION_TYPE=Service',
                    'ADDLOCAL=Service',
                    'SERVICE_PORT=8080',
                    'SERVICE_NAME=RavenDB',
                    '"',
                  ]).that_requires('File[C:\\RavenDB-3.5.4.Setup.exe]')
        }

        it {
          is_expected.to contain_file('C:\\RavenDB-3.5.4.Tools.zip')
            .with(ensure: 'absent',
                  source: 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.4.Tools.zip')
        }
      end

      context 'with package_ensure => absent' do
        let(:params) do
          {
            package_ensure: 'absent',
          }
        end

        it {
          is_expected.to contain_file('C:\\RavenDB-3.5.4.Setup.exe')
            .with(ensure: 'absent',
                  source: 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.4.Setup.exe')
        }

        it {
          is_expected.to contain_package('RavenDB')
            .with(ensure: 'absent').that_requires('File[C:\\RavenDB-3.5.4.Setup.exe]')
        }
      end

      context 'with include_management_tools => true' do
        let(:params) do
          {
            include_management_tools: true,
          }
        end

        it {
          is_expected.to contain_file('C:\\RavenDB-3.5.4.Tools.zip')
            .with(ensure: 'file',
                  source: 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.4.Tools.zip')
        }

        it {
          is_expected.to contain_dsc_archive('Unzip RavenDB Tools')
            .with(ensure: 'present',
                  dsc_path: 'C:\\RavenDB-3.5.4.Tools.zip',
                  dsc_destination: 'C:\\RavenDB Tools')
        }
      end
    end
  end
end
