require 'spec_helper'
describe 'ravendb::install' do
  context 'with default values for all parameters' do
    it { should contain_class('ravendb::install') }
    it { should contain_class('ravendb::params') }

    it { should contain_file('C:\\RavenDB-3.5.4.Setup.exe').with({
      :ensure => 'file',
      :source => 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.4.Setup.exe',
    }) }

    it { should contain_package('RavenDB').with({
      :ensure          => 'present',
      :source          => 'C:\\RavenDB-3.5.4.Setup.exe',
      :install_options => [
        '/quiet',
        '/log',
        'C:\\RavenDB.install.log',
        '/msicl',
        '"',
        'RAVEN_TARGET_ENVIRONMENT=development',
        'RAVEN_WORKING_DIR=~\\',
        'INSTALLFOLDER=C:\\RavenDB',
        'RAVEN_DATA_DIR=C:\\RavenDB\\Databases',
        "RAVENFS_DATA_DIR=C:\\RavenDB\\FileSystems",
        'RAVEN_INSTALLATION_TYPE=Service',
        'ADDLOCAL=Service',
        "SERVICE_PORT=8080",
        "SERVICE_NAME=RavenDB",
        '"',
      ],
    }).that_requires('File[C:\\RavenDB-3.5.4.Setup.exe]')}

  end

  context 'with package_ensure => absent' do
    let(:params) {{
      :package_ensure => 'absent',
    }}

    it { should contain_file('C:\\RavenDB-3.5.4.Setup.exe').with({
      :ensure => 'absent',
      :source => 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.4.Setup.exe',
    }) }
    
    it { should contain_package('RavenDB').with({
      :ensure => 'absent',
      :source => 'C:\\RavenDB-3.5.4.Setup.exe',
    }).that_requires('File[C:\\RavenDB-3.5.4.Setup.exe]')}

  end
end
