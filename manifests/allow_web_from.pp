

define dofirewall::allow_web_from {
  firewall { "110 accept web traffic: $title":
    proto  => 'tcp',
    dport  => [80, 443],
    action => 'accept',
    source => $title,
  }
}
