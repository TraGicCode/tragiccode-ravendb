# Class: ravendb::params
#
#
class ravendb::params {
  $package_ensure = 'present'
  $ravendb_download_absolute_path = 'C:\\RavenDB-3.5.3.Setup.exe'
  $ravendb_download_url = 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.3.Setup.exe'
  $ravendb_install_log_absolute_path = 'C:\\RavenDB.install.log'
  $ravendb_target_environment = 'development'
  $ravendb_working_directory = 'C:\\RavenDB'
  $ravendb_install_folder = 'C:\\RavenDB'
  $ravendb_database_directory = 'C:\\RavenDB\\Databases'
  $ravendb_filesystems_database_directory = 'C:\\RavenDB\\FileSystems'

  # $ravendb_installation_type = 'Service'
  $ravendb_service_name = 'RavenDB'
  $ravendb_port = 8080

}