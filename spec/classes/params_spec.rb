require 'spec_helper'

describe 'ravendb::params' do
  context 'with default values for all parameters' do

    it { should contain_class('ravendb::params') }
    # This is a params class....
    it { is_expected.to have_resource_count(0) }

  end
end