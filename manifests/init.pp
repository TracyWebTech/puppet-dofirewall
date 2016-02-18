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

  if ($allow_all_from) {
    dofirewall::allow_all_from { $allow_all_from: }
  }

  if ($allow_ports) {
    dofirewall::allow_ports { $allow_ports: }
  }
}
