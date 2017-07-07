# Class: ravendb::install
#
#
class ravendb::install(
  Enum['installed', 'present', 'absent'] $package_ensure        = $ravendb::params::package_ensure,
  String $ravendb_service_name                                  = $ravendb::params::ravendb_service_name,
  Integer $ravendb_port                                         = $ravendb::params::ravendb_port,
  Stdlib::Absolutepath $ravendb_install_log_absolute_path       = $ravendb::params::ravendb_install_log_absolute_path,
  Stdlib::Absolutepath $ravendb_uninstall_log_absolute_path     = $ravendb::params::ravendb_uninstall_log_absolute_path,
  Enum['development', 'production'] $ravendb_target_environment = $ravendb::params::ravendb_target_environment,
  Stdlib::Absolutepath $ravendb_database_directory              = $ravendb::params::ravendb_database_directory,
  Stdlib::Absolutepath $ravendb_filesystems_database_directory  = $ravendb::params::ravendb_filesystems_database_directory,
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
  # RAVEN_WORKING_DIR = C:\Raven
  # RAVEN_DATA_DIR = ~\Databases
  # RAVENFS_DATA_DIR = ~\FileSystems
  # RAVEN_TARGET_ENVIRONMENT = DEVELOPMENT
  # RAVEN_INSTALLATION_TYPE = SERVICE
  # SERVICE_NAME = RavenDB
  # SERVICE_PORT = 8080
  # INSTALLFOLDER = C:\RavenDB\

  # C:\Users\tragiccode\Downloads\RavenDB-3.5.3.Setup.exe /quiet /log C:\RavenDB.install.log /msicl "RAVEN_TARGET_ENVIRONMENT=production RAVEN_WORKING_DIR=~\ INSTALLFOLDER=C:\RavenDB RAVEN_INSTALLATION_TYPE=Service ADDLOCAL=Service"
  package { 'RavenDB':
    ensure            => $package_ensure,
    source            => $ravendb::params::ravendb_download_absolute_path,
    install_options   => [
      '/quiet',
      '/log',
      $ravendb_install_log_absolute_path,
      '/msicl',
      '"',
      "RAVEN_TARGET_ENVIRONMENT=${ravendb_target_environment}",
      'RAVEN_WORKING_DIR=~\\', # Where you want the Databases + Assemblies folder to live
      'INSTALLFOLDER=C:\\RavenDB', # Where you want the actual ravendb application binaries to live
      "RAVEN_DATA_DIR=${ravendb_database_directory}",
      "RAVENFS_DATA_DIR=${ravendb_filesystems_database_directory}",
      'RAVEN_INSTALLATION_TYPE=Service',
      'ADDLOCAL=Service',
      "SERVICE_PORT=${ravendb_port}",
      "SERVICE_NAME=${ravendb_service_name}",
      '"',
    ],
    uninstall_options => [
      '/quiet',
      '/log',
      $ravendb_uninstall_log_absolute_path,
    ],
  }

  File[$ravendb::params::ravendb_download_absolute_path]
  -> Package['RavenDB']

}
