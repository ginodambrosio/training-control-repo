
class profile::timeserver {

include ntp

class { 'ntp':
    servers => [ 'time.asia.apple.com', 'time.optusnet.com.au' ],
  }
}