class profile::hiera_test (
  Optional[String[1]] $testvar = undef,
) {
  # OS-specific
  case $facts['kernel'] {
    'windows': {
      $temp = 'C:/Temp'
      notify {"Got to windows ${temp}":}
    }
    'Linux': {
      $temp = '/tmp'
      notify {"Got to linux ${temp}":}
    }
  default: {
    fail('Unsupported operating system!')
  }
  }
#  file { '$temp/hiera_test.txt':
#    ensure  => file,
#    content => @("END"),
#               Data from profile::hiera_test
#               -----
#               profile::hiera_test::myvar= ${myvar}
#               profile::hiera_test::testvar= ${testvar}
#               profile::hiera_test::environment= ${::environment}
#               |END
#    owner   => root,
#    mode    => '0644',
#  }
#  notify{"myvar: ${myvar} | testvar: ${testvar} | environment: $::environment": }
}
