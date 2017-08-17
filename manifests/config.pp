# Class: ravendb::config
#
#
class ravendb::config(
  Stdlib::Absolutepath $ravendb_server_exe_config_absolute_path = $ravendb::params::ravendb_server_exe_config_absolute_path,
  Integer $ravendb_port                                         = $ravendb::params::ravendb_port,
) inherits ravendb::params {

  $raven_server_exe_config_hash = {
    'ravendb_port' => $ravendb_port,
  }

  file { $ravendb_server_exe_config_absolute_path:
    ensure  => file,
    content => regsubst(epp('ravendb/Raven.Server.exe.config.epp', $raven_server_exe_config_hash), '\n', "\r\n", 'EMG'),
  }

}