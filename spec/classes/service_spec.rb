require 'spec_helper'
describe 'ravendb::service' do
  context 'with default values for all parameters' do
    it { should contain_class('ravendb::service') }
    it { should contain_class('ravendb::params') }

    it { should contain_service('RavenDB').with({
      :ensure => 'running',
      :enable => true,
    }) }

  end
end
