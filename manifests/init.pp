class dofirewall {
  include dofirewall::pre
  include dofirewall::post
  include firewall

  resources { 'firewall':
    purge => true,
  }

  Firewall {
    before  => Class['dofirewall::post'],
    require => Class['dofirewall::pre'],
  }

  @@firewall { "100 allow internal traffic $::fqdn":
    proto  => 'all',
    action => 'accept',
    source => $::ipaddress_eth1,
  }

  Firewall <<| |>>

  firewall { "101 allow ssh from anywhere":
    proto  => 'tcp',
    port   => 22,
    action => 'accept',
  }
}
