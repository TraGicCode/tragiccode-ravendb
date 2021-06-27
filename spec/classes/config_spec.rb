require 'spec_helper'

describe 'ravendb::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default values for all parameters' do
        it { is_expected.to contain_class('ravendb::config') }
        it { is_expected.to contain_class('ravendb::params') }

        it {
          is_expected.to contain_file('C:\\RavenDB\Raven.Server.exe.config').with(ensure: 'file')
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/Port" value="8080"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/DataDir/Legacy" value="~\Database\System"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/DataDir" value="~\Databases\System"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/AnonymousAccess" value="Admin"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/Licensing/AllowAdminAnonymousAccessForCommercialUse" value="false"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/AccessControlAllowOrigin" value="*"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/IndexStoragePath" value=""/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/TransactionJournalsPath" value=""/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/WorkingDir" value="~\"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/FileSystem/DataDir" value="~\FileSystems"/>')}})
        }

        it {
          is_expected.to contain_file('C:\\RavenDB\Raven.Server.exe.config').with_content(%r{#{Regexp.escape("\r\n")}})
        }
      end

      context 'with config => { Raven/Esent/MaxVerPages => 6144, Raven/Esent/DbExtensionSize => 128 }' do
        let(:params) do
          {
            config: { 'Raven/Esent/MaxVerPages' => 6144, 'Raven/Esent/DbExtensionSize' => 128 },
          }
        end

        it {
          is_expected.to contain_file('C:\\RavenDB\Raven.Server.exe.config').with(ensure: 'file')
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/Port" value="8080"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/Esent/MaxVerPages" value="6144"/>')}})
                                                                            .with_content(%r{#{Regexp.escape('<add key="Raven/Esent/DbExtensionSize" value="128"/>')}})
        }
      end
    end
  end
end
