require 'spec_helper_acceptance'

describe 'ravendb' do

  context 'when installing with provided mandatory parameters' do
    let(:install_manifest) {
      <<-MANIFEST
          class { 'ravendb':
              package_ensure       => 'present',
              ravendb_service_name => 'RavenDB',
              ravendb_port         => 8080,
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

    describe port(8080) do
      it { should be_listening }
    end

    describe service('RavenDB') do
      it { should be_installed }
      it { should be_running }
      it { should be_enabled }
    end
  end

end