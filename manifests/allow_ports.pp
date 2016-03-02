
define dofirewall::allow_ports {
  firewall { "102 accept all on port $title":
    proto  => 'tcp',
    dport  => $title,
    action => 'accept',
  }
}
