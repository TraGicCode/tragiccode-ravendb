require 'spec_helper'
describe 'ravendb::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default values for all parameters' do
        it { is_expected.to contain_class('ravendb::service') }
        it { is_expected.to contain_class('ravendb::params') }

        it {
          is_expected.to contain_service('RavenDB')
            .with(ensure: 'running',
                  enable: true)
        }
        it {
          is_expected.to contain_exec('wait-for-service-to-start')
        }
      end

      context 'with package_ensure => absent' do
        let(:params) do
          {
            package_ensure: 'absent',
          }
        end

        it { is_expected.not_to contain_service('RavenDB') }
        it { is_expected.not_to contain_exec('wait-for-service-to-start') }
      end
    end
  end
end
