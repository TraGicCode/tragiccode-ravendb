# Class: ravendb::params
#
#
class ravendb::params {
  $package_ensure = 'present'
  $include_management_tools = false
  $ravendb_download_base_url = 'https://daily-builds.s3.amazonaws.com'
  $ravendb_download_absolute_path = 'C:\\RavenDB-3.5.4.Setup.exe'
  $ravendb_download_url = "${ravendb_download_base_url}/RavenDB-3.5.4.Setup.exe"
  $management_tools_download_url = "${ravendb_download_base_url}/RavenDB-3.5.4.Tools.zip"
  $management_tools_download_absolute_path = 'C:\\RavenDB-3.5.4.Tools.zip'
  $management_tools_install_directory = 'C:\\RavenDB Tools'
  $ravendb_install_log_absolute_path = 'C:\\RavenDB.install.log'
  $ravendb_uninstall_log_absolute_path = 'C:\\RavenDB.uninstall.log'
  $ravendb_target_environment = 'development'
  $ravendb_working_directory = 'C:\\RavenDB'
  $ravendb_install_folder = 'C:\\RavenDB'
  $ravendb_database_directory = 'C:\\RavenDB\\Databases'
  $ravendb_filesystems_database_directory = 'C:\\RavenDB\\FileSystems'
  $config_defaults = {
    'Raven/DataDir/Legacy'  => '~\Database\System',
    'Raven/DataDir'         => '~\Databases\System',
    'Raven/AnonymousAccess' => 'Admin',
    'Raven/Licensing/AllowAdminAnonymousAccessForCommercialUse' => false,
    'Raven/AccessControlAllowOrigin' => '*',
    'Raven/IndexStoragePath' => '',
    'Raven/TransactionJournalsPath' => '',
    'Raven/WorkingDir' => '~\\',
    'Raven/FileSystem/DataDir' => '~\FileSystems',
  }
  $config = {
  }


  # $ravendb_installation_type = 'Service'
  $ravendb_service_name = 'RavenDB'
  $ravendb_port = 8080
  $service_ensure = 'running'
  $service_enable = true
  $service_restart_on_config_change = true

  $ravendb_server_exe_config_absolute_path = "${ravendb_install_folder}\\Raven.Server.exe.config"

}
