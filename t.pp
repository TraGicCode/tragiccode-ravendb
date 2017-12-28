package { 'ravendb-api-client':
  ensure   => 'latest',
  provider => 'puppet_gem'
}


ravendb_database { 'test':
  ensure => 'present',

}
