require 'spec_helper'
describe 'ravendb::install' do
  context 'with default values for all parameters' do
    it { should contain_class('ravendb::install') }
    it { should contain_class('ravendb::params')}
  end
end
