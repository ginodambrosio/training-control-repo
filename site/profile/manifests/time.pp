
class profile::time (
  Array $servers = [ 'time.asia.apple.com', 'time.optusnet.com.au' ],
) {
class { 'ntp':
    servers => $servers,
  }
}
