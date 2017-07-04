require 'spec_helper'
describe 'ravendb' do
  context 'with default values for all parameters' do
    it { should contain_class('ravendb') }
    it { should contain_class('ravendb::params') }
    it { should contain_class('ravendb::install').with({
      :package_ensure                         => 'present',
      :ravendb_service_name                   => 'RavenDB',
      :ravendb_port                           => '8080',
      :ravendb_target_environment             => 'development',
      :ravendb_install_log_absolute_path      => 'C:\\RavenDB.install.log',
      :ravendb_database_directory             => 'C:\\RavenDB\\Databases',
      :ravendb_filesystems_database_directory => 'C:\\RavenDB\\FileSystems',
    }) }
    it { should contain_class('ravendb::config').that_requires('Class[ravendb::install]') }
    it { should contain_class('ravendb::service').that_requires('Class[ravendb::config]') }
  end
end
