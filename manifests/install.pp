# Class: ravendb::install
#
#
class ravendb::install(
  Enum['installed', 'present', 'absent'] $package_ensure        = $ravendb::params::package_ensure,
  String $ravendb_service_name                                  = $ravendb::params::ravendb_service_name,
  Integer $ravendb_port                                         = $ravendb::params::ravendb_port,
  Stdlib::Absolutepath $ravendb_install_log_absolute_path       = $ravendb::params::ravendb_install_log_absolute_path,
  Enum['development', 'production'] $ravendb_target_environment = $ravendb::params::ravendb_target_environment,
) inherits ravendb::params {

  $file_ensure = $package_ensure ? {
    'installed' => 'file',
    'present'   => 'file',
    default     => 'absent',
  }
  file { $ravendb::params::ravendb_download_absolute_path:
    ensure => $file_ensure,
    source => $ravendb::params::ravendb_download_url,
  }
  # https://chocolatey.org/packages/RavenDB3
  # https://github.com/ravendb/ravendb/blob/f3b5f3a186d07776bf38bf9effab4d7d75d5c647/Raven.Setup/Settings.wxi
  package { 'RavenDB':
    ensure          => $package_ensure,
    source          => $ravendb::params::ravendb_download_absolute_path,
    install_options => [
      '/quiet',
      '/log',
      $ravendb_install_log_absolute_path,
      '/msicl',
      '"',
      "RAVEN_TARGET_ENVIRONMENT=${ravendb_target_environment}",
      'RAVEN_WORKING_DIR=~\\', # Where you want the Databases + Assemblies folder to live
      'INSTALLFOLDER=C:\\RavenDB', # Where you want the actual ravendb application binaries to live
      'RAVEN_INSTALLATION_TYPE=Service',
      'ADDLOCAL=Service',
      "SERVICE_PORT=${ravendb_port}",
      "SERVICE_NAME=${ravendb_service_name}",
      '"',
    ],
  }

}