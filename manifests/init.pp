# Class: ravendb
#
#
class ravendb(
  Enum['installed', 'present', 'absent'] $package_ensure                  = $ravendb::params::package_ensure,
  Boolean $include_management_tools                                       = $ravendb::params::include_management_tools,
  Optional[Stdlib::Httpurl] $management_tools_download_url                = $ravendb::params::management_tools_download_url,
  Optional[Stdlib::Absolutepath] $management_tools_download_absolute_path = $ravendb::params::management_tools_download_absolute_path,
  Optional[Stdlib::Absolutepath] $management_tools_install_directory      = $ravendb::params::management_tools_install_directory,
  String $ravendb_service_name                                            = $ravendb::params::ravendb_service_name,
  Integer $ravendb_port                                                   = $ravendb::params::ravendb_port,
  Stdlib::Absolutepath $ravendb_install_log_absolute_path                 = $ravendb::params::ravendb_install_log_absolute_path,
  Stdlib::Absolutepath $ravendb_uninstall_log_absolute_path               = $ravendb::params::ravendb_uninstall_log_absolute_path,
  Enum['development', 'production'] $ravendb_target_environment           = $ravendb::params::ravendb_target_environment,
  Stdlib::Absolutepath $ravendb_database_directory                        = $ravendb::params::ravendb_database_directory,
  Stdlib::Absolutepath $ravendb_filesystems_database_directory            = $ravendb::params::ravendb_filesystems_database_directory,
  Enum['running', 'stopped'] $service_ensure                              = $ravendb::params::service_ensure,
  Variant[ Boolean, Enum['manual'] ] $service_enable                      = $ravendb::params::service_enable,
  Boolean $service_restart_on_config_change                               = $ravendb::params::service_restart_on_config_change,
  Hash $config                                                            = $ravendb::params::config,
) inherits ravendb::params {

  class { 'ravendb::install':
    package_ensure                          => $package_ensure,
    include_management_tools                => $include_management_tools,
    management_tools_download_url           => $management_tools_download_url,
    management_tools_download_absolute_path => $management_tools_download_absolute_path,
    management_tools_install_directory      => $management_tools_install_directory,
    ravendb_service_name                    => $ravendb_service_name,
    ravendb_port                            => $ravendb_port,
    ravendb_install_log_absolute_path       => $ravendb_install_log_absolute_path,
    ravendb_uninstall_log_absolute_path     => $ravendb_uninstall_log_absolute_path,
    ravendb_target_environment              => $ravendb_target_environment,
    ravendb_database_directory              => $ravendb_database_directory,
    ravendb_filesystems_database_directory  => $ravendb_filesystems_database_directory,
  }

  class { 'ravendb::config':
    ravendb_server_exe_config_absolute_path => $ravendb::params::ravendb_server_exe_config_absolute_path,
    ravendb_port                            => $ravendb_port,
    config                                  => $config,
  }

  class { 'ravendb::service':
    package_ensure => $package_ensure,
    service_ensure => $service_ensure,
    service_enable => $service_enable,
  }

  Class['ravendb::install']
  -> Class['ravendb::config']

  if ($service_restart_on_config_change) {
    Class['ravendb::config'] ~> Class['ravendb::service']

  } else {
    Class['ravendb::config'] -> Class['ravendb::service']
  }

}
