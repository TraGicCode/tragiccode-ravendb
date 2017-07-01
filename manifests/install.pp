# Class: ravendb::install
#
#
class ravendb::install(
  Enum['installed', 'present', 'absent'] $package_ensure = $ravendb::params::package_ensure,
) inherits ravendb::params {
  # resources


}