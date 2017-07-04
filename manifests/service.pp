# Class: ravendb::service
#
#
class ravendb::service(
  Enum['running', 'stopped'] $service_ensure         = $ravendb::params::service_ensure,
  Variant[ Boolean, Enum['manual'] ] $service_enable = $ravendb::params::service_enable,
  String $ravendb_service_name                       = $ravendb::params::ravendb_service_name,
) inherits ravendb::params {

  service { $ravendb_service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }
}