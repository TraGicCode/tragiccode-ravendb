# Class: ravendb::service
#
#
class ravendb::service(
  Enum['installed', 'present', 'absent'] $package_ensure = $ravendb::params::package_ensure,
  Enum['running', 'stopped'] $service_ensure             = $ravendb::params::service_ensure,
  Variant[ Boolean, Enum['manual'] ] $service_enable     = $ravendb::params::service_enable,
  String $ravendb_service_name                           = $ravendb::params::ravendb_service_name,
) inherits ravendb::params {
  if $package_ensure != 'absent' {

    # This is needed because after install of the package a refresh is fired from config.pp
    # When puppet gets here the service is in a i'm starting state.  so i need to have someway to
    # keep trying to restart-service.
    exec { 'wait-for-service-to-start':
        # lint:ignore:140chars
        command     => "powershell.exe -ExecutionPolicy ByPass -Command \"try { \$svc = Get-Service ${ravendb_service_name} -ErrorAction Stop; \$svc.WaitForStatus('Running','00:01:00'); exit 0 } catch { Write-Output \$_.Exception.Message; exit 1 }\"",
        # lint:endignore
        path        => ['C:\Windows\System32\WindowsPowerShell\v1.0'],
        logoutput   => true,
        refreshonly => true,
      }

    service { $ravendb_service_name:
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }
}
