
class dofirewall::cloudflare {

  # from https://www.cloudflare.com/ips-v4
  $cloudflare_ips = [
    "199.27.128.0/21",
    "173.245.48.0/20",
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "141.101.64.0/18",
    "108.162.192.0/18",
    "190.93.240.0/20",
    "188.114.96.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17",
    "162.158.0.0/15",
  ]

  define allow_web_from {
    firewall { "110 accept web traffic":
      proto  => 'tcp',
      port   => [80, 443],
      action => 'accept',
      source => $title,
    }
  }

  create_resources(allow_web_from, $cloudflare_ips)
}
