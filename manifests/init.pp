class dofirewall (
  $allow_all_from = [],
) {

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

  @@firewall { "100 accept internal traffic $::fqdn":
    proto  => 'all',
    action => 'accept',
    source => $::ipaddress_eth1,
  }

  Firewall <<| |>>

  define allow_all_from {
    firewall { "101 accept all from $title":
      proto  => 'all',
      action => 'accept',
      source => $title,
    }
  }

  if ($allow_all_from) {
    allow_all_from { $allow_all_from: }
  }

  firewall { "102 accept ssh from anywhere":
    proto  => 'tcp',
    port   => 22,
    action => 'accept',
  }
}
