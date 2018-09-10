# Class: ravendb::config
#
#
class ravendb::config(
  Stdlib::Absolutepath $ravendb_server_exe_config_absolute_path = $ravendb::params::ravendb_server_exe_config_absolute_path,
  Integer $ravendb_port                                         = $ravendb::params::ravendb_port,
  Hash $config                                                  = $ravendb::params::config,
) inherits ravendb::params {

  $_config_hash = merge($ravendb::params::config_defaults, $config)

  file { $ravendb_server_exe_config_absolute_path:
    ensure  => file,
    content => unix2dos(epp('ravendb/Raven.Server.exe.config.epp', {
        'config_hash'  => $_config_hash,
        'ravendb_port' => $ravendb_port,
      })),
  }

}
