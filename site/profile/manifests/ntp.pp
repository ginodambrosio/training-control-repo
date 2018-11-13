
class profile::ntp {

include ntp

ntp::ntp { 'ntp':
    servers => [ 'time.asia.apple.com', 'time.optusnet.com.au' ],
  }
}
