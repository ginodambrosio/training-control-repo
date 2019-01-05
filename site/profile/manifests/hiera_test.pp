class profile::hiera_test (
  Optional[String[1]] $testvar = undef,
) {
  # OS-specific
  case $facts['kernel'] {
    'windows': {
      $tempdir = 'C:/Temp/'
      $tempfile = 'hiera_test.txt'
      notify {"Windows ${tempdir}${tempfile}":}
    }
    'Linux': {
      $tempdir = '/tmp/'
      $tempfile = 'hiera_test.txt'
      notify {"Linux ${tempdir}${tempfile}":}
    }
  default: {
    fail('Unsupported operating system!')
    }
  }
  file { $tempfile:
    path    => $tempdir,
    ensure  => file,
    content => @("END"),
               Data from profile::hiera_test
               -----
               profile::hiera_test::myvar= ${myvar}
               profile::hiera_test::testvar= ${testvar}
               profile::hiera_test::environment= ${::environment}
               |END
#    owner   => root,
#    mode    => '0644',
  }
  notify{"myvar: ${myvar} | testvar: ${testvar} | environment: $::environment": }
}
