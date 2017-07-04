# Class: ravendb
# ===========================
#
# Full description of class ravendb here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'ravendb':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class ravendb(
  Enum['installed', 'present', 'absent'] $package_ensure        = $ravendb::params::package_ensure,
  String $ravendb_service_name                                  = $ravendb::params::ravendb_service_name,
  Integer $ravendb_port                                         = $ravendb::params::ravendb_port,
  Stdlib::Absolutepath $ravendb_install_log_absolute_path       = $ravendb::params::ravendb_install_log_absolute_path,
  Enum['development', 'production'] $ravendb_target_environment = $ravendb::params::ravendb_target_environment,

) inherits ravendb::params {

  class { 'ravendb::install':
    package_ensure                    => $package_ensure,
    ravendb_service_name              => $ravendb_service_name,
    ravendb_port                      => $ravendb_port,
    ravendb_install_log_absolute_path => $ravendb_install_log_absolute_path,
    ravendb_target_environment        => $ravendb_target_environment,
  }

  class { 'ravendb::config':

  }

  class { 'ravendb::service':

  }

  Class['ravendb::install']
  -> Class['ravendb::config']
  -> Class['ravendb::service']

}
