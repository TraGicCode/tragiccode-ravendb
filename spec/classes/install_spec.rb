require 'spec_helper'
describe 'ravendb::install' do
  context 'with default values for all parameters' do
    it { should contain_class('ravendb::install') }
    it { should contain_class('ravendb::params') }

    it { should contain_file('C:\\RavenDB-3.5.3.Setup.msi').with({
      :ensure => 'file',
      :source => 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.3.Setup.exe',
    }) }

    it { should contain_package('RavenDB').with({
      :ensure => 'present',
      :source => 'C:\\RavenDB-3.5.3.Setup.msi',
    }).that_requires('File[C:\\RavenDB-3.5.3.Setup.msi]')}

  end

  context 'with package_ensure => absent' do
    let(:params) {{
      :package_ensure => 'absent',
    }}

    it { should contain_file('C:\\RavenDB-3.5.3.Setup.msi').with({
      :ensure => 'absent',
      :source => 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.3.Setup.exe',
    }) }
    
    it { should contain_package('RavenDB').with({
      :ensure => 'absent',
      :source => 'C:\\RavenDB-3.5.3.Setup.msi',
    }).that_requires('File[C:\\RavenDB-3.5.3.Setup.msi]')}

  end
end
