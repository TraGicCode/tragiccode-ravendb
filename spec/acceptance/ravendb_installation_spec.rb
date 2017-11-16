require 'spec_helper_acceptance'

describe 'ravendb' do
  context 'when installing with provided mandatory parameters' do
    let(:install_manifest) do
      <<-MANIFEST
          class { 'ravendb':
              package_ensure                         => 'present',
              include_management_tools               => false,
              ravendb_service_name                   => 'RavenDB',
              ravendb_port                           => 8080,
              ravendb_install_log_absolute_path      => 'C:\\RavenDB.install.log',
              ravendb_database_directory             => 'C:\\RavenDB\\Databases',
              ravendb_filesystems_database_directory => 'C:\\RavenDB\\FileSystems',
          }
        MANIFEST
    end

    it 'runs without errors' do
      apply_manifest(install_manifest, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(install_manifest, catch_changes: true)
    end

    describe file('C:\RavenDB-3.5.4.Tools.zip') do
      it { is_expected.not_to exist }
    end

    describe file('C:\RavenDB Tools') do
      it { is_expected.not_to exist }
    end

    describe file('C:\RavenDB-3.5.4.Setup.exe') do
      it { is_expected.to exist }
    end

    describe file('C:\RavenDB.install.log') do
      it { is_expected.to exist }
    end

    describe package('RavenDB') do
      it { is_expected.to be_installed }
    end

    describe port(8080) do
      it { is_expected.to be_listening }
    end

    describe service('RavenDB') do
      it { is_expected.to be_installed }
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end

  context 'when uninstalling with provided mandatory parameters' do
    let(:install_manifest) do
      <<-MANIFEST
          class { 'ravendb':
              package_ensure                      => 'absent',
              ravendb_uninstall_log_absolute_path => 'C:\\RavenDB.uninstall.log',
          }
        MANIFEST
    end

    it 'runs without errors' do
      apply_manifest(install_manifest, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(install_manifest, catch_changes: true)
    end

    describe file('C:\RavenDB-3.5.4.Setup.exe') do
      it { is_expected.not_to exist }
    end

    describe file('C:\RavenDB.uninstall.log') do
      it { is_expected.to exist }
    end

    describe package('RavenDB') do
      it { is_expected.not_to be_installed }
    end

    describe port(8080) do
      it { is_expected.not_to be_listening }
    end

    describe service('RavenDB') do
      it { is_expected.not_to be_installed }
      it { is_expected.not_to be_running }
      it { is_expected.not_to be_enabled }
    end
  end
end
