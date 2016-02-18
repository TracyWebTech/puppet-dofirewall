
define dofirewall::allow_all_from {
  firewall { "101 accept all from $title":
    proto  => 'all',
    action => 'accept',
    source => $title,
  }
}
