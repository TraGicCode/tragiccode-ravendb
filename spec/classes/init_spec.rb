require 'spec_helper'
describe 'ravendb' do
  context 'with default values for all parameters' do
    it { should contain_class('ravendb') }
  end
end
