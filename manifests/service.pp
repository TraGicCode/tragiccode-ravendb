# Class: ravendb::service
#
#
class ravendb::service(
  Enum['installed', 'present', 'absent'] $package_ensure        = $ravendb::params::package_ensure,
  Enum['running', 'stopped'] $service_ensure         = $ravendb::params::service_ensure,
  Variant[ Boolean, Enum['manual'] ] $service_enable = $ravendb::params::service_enable,
  String $ravendb_service_name                       = $ravendb::params::ravendb_service_name,
) inherits ravendb::params {
  if $package_ensure != 'absent' {
    service { $ravendb_service_name:
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }
}