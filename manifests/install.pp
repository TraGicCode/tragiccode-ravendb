# Class: ravendb::install
#
#
class ravendb::install(
  Enum['installed', 'present', 'absent'] $package_ensure = $ravendb::params::package_ensure,
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

  package { 'RavenDB':
    ensure => $package_ensure,
    source => $ravendb::params::ravendb_download_absolute_path,
  }

}