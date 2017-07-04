# Class: ravendb
#
#
class ravendb(
  Enum['installed', 'present', 'absent'] $package_ensure        = $ravendb::params::package_ensure,
  String $ravendb_service_name                                  = $ravendb::params::ravendb_service_name,
  Integer $ravendb_port                                         = $ravendb::params::ravendb_port,
  Stdlib::Absolutepath $ravendb_install_log_absolute_path       = $ravendb::params::ravendb_install_log_absolute_path,
  Enum['development', 'production'] $ravendb_target_environment = $ravendb::params::ravendb_target_environment,
  Stdlib::Absolutepath $ravendb_database_directory              = $ravendb::params::ravendb_database_directory,
  Stdlib::Absolutepath $ravendb_filesystems_database_directory  = $ravendb::params::ravendb_filesystems_database_directory,
  Enum['running', 'stopped'] $service_ensure                    = $ravendb::params::service_ensure,
  Variant[ Boolean, Enum['manual'] ] $service_enable            = $ravendb::params::service_enable,
) inherits ravendb::params {

  class { 'ravendb::install':
    package_ensure                         => $package_ensure,
    ravendb_service_name                   => $ravendb_service_name,
    ravendb_port                           => $ravendb_port,
    ravendb_install_log_absolute_path      => $ravendb_install_log_absolute_path,
    ravendb_target_environment             => $ravendb_target_environment,
    ravendb_database_directory             => $ravendb_database_directory,
    ravendb_filesystems_database_directory => $ravendb_filesystems_database_directory,
  }

  class { 'ravendb::config':

  }

  class { 'ravendb::service':
    service_ensure => $service_ensure,
    service_enable => $service_enable,
  }

  Class['ravendb::install']
  -> Class['ravendb::config']
  ~> Class['ravendb::service']

}
