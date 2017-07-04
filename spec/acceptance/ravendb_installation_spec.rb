require 'spec_helper_acceptance'

describe 'ravendb' do

  context 'when installing with provided mandatory parameters' do
    let(:install_manifest) {
      <<-MANIFEST
          class { 'ravendb':
              package_ensure                         => 'present',
              ravendb_service_name                   => 'RavenDB',
              ravendb_port                           => 8080,
              ravendb_install_log_absolute_path      => 'C:\\RavenDB.install.log',
              ravendb_database_directory             => 'C:\\RavenDB\\Databases'
              ravendb_filesystems_database_directory => 'C:\\RavenDB\\FileSystems',
          }
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(install_manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(install_manifest, :catch_changes => true)
    end
    

    describe file('C:\RavenDB-3.5.3.Setup.exe') do
       it { should exist }
    end

    describe file('C:\RavenDB.install.log') do
       it { should exist }
    end

    describe package('RavenDB') do
      it { should be_installed }
    end

    describe port(8080) do
      it { should be_listening }
    end

    describe service('RavenDB') do
      it { should be_installed }
      it { should be_running }
      it { should be_enabled }
    end
  end


    context 'when uninstalling with provided mandatory parameters' do
    let(:install_manifest) {
      <<-MANIFEST
          class { 'ravendb':
              package_ensure                      => 'absent',
              ravendb_uninstall_log_absolute_path => 'C:\\RavenDB.uninstall.log',
          }
        MANIFEST
    }

    it 'should run without errors' do
      apply_manifest(install_manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(install_manifest, :catch_changes => true)
    end

    describe file('C:\RavenDB-3.5.3.Setup.exe') do
       it { should_not exist }
    end

    describe file('C:\RavenDB.uninstall.log') do
       it { should exist }
    end

    describe package('RavenDB') do
      it { should_not be_installed }
    end

    describe port(8080) do
      it { should_not be_listening }
    end

    describe service('RavenDB') do
      it { should_not be_installed }
      it { should_not be_running }
      it { should_not be_enabled }
    end
  end

end