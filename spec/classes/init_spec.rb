require 'spec_helper'
describe 'ravendb' do
  context 'with default values for all parameters' do
    it { should contain_class('ravendb') }
    it { should contain_class('ravendb::params') }
    it { should contain_class('ravendb::install') }
    it { should contain_class('ravendb::config').that_requires('Class[ravendb::install]') }
    it { should contain_class('ravendb::service').that_requires('Class[ravendb::config]') }
  end
end
