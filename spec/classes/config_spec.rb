require 'spec_helper'

describe 'ravendb::config' do
  context 'with default values for all parameters' do

    it { should contain_class('ravendb::config') }
    it { should contain_class('ravendb::params') }

    it { should contain_file('C:\\RavenDB\Raven.Server.exe.config').with({
      :ensure  => 'file',
    })
    .with_content(/#{Regexp.escape('<add key="Raven/Port" value="8080"/>')}/) }
  end

  context 'config => { owner => root, group => root, mode => 0644 }' do
    let (:params) {{
      :config => { 'Raven/Esent/MaxVerPages' => 6144, 'Raven/Esent/DbExtensionSize' => 128, }
    }}
    it { should contain_file('C:\\RavenDB\Raven.Server.exe.config').with({
      :ensure  => 'file',
    })
    .with_content(/#{Regexp.escape('<add key="Raven/Port" value="8080"/>')}/)
    .with_content(/#{Regexp.escape('<add key="Raven/Esent/MaxVerPages" value="6144"/>')}/)
    .with_content(/#{Regexp.escape('<add key="Raven/Esent/DbExtensionSize" value="128"/>')}/) }
  end
end