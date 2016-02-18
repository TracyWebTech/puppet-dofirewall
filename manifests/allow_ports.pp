
define dofirewall::allow_ports {
  firewall { "102 accept all on port $title":
    proto  => 'tcp',
    port   => $title,
    action => 'accept',
  }
}
