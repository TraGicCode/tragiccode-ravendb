require 'spec_helper'

describe 'ravendb::config' do
  context 'with default values for all parameters' do

    it { should contain_class('ravendb::config') }
    it { should contain_class('ravendb::params') }

  end
end