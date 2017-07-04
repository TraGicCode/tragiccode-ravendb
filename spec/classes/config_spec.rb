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
end