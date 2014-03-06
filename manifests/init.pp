class dofirewall (
  $allow_all_from = [],
  $allow_ports = [],
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

  define allow_ports {
    firewall { "102 accept all on port $title":
      proto  => 'all',
      port   => $title,
      action => 'accept',
    }
  }

  if ($allow_ports) {
    allow_ports { $allow_ports: }
  }
}
