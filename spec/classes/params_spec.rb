require 'spec_helper'

describe 'ravendb::params' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default values for all parameters' do
        it { is_expected.to contain_class('ravendb::params') }
        # This is a params class....
        it { is_expected.to have_resource_count(0) }
      end
    end
  end
end
