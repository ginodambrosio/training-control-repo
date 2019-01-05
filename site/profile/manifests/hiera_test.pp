class profile::hiera_test (
  Optional[String[1]] $testvar = undef,
) {
  # OS-specific
  case $facts['kernel'] {
    'windows': {
      $tempfile = 'C:\\Temp\\hiera_test.txt'
      # notify {"Windows ${tempfile}":}
    }
    'Linux': {
      $tempfile = '/tmp/hiera_test.txt'
      # notify {"Linux ${tempfile}":}
    }
  default: {
    fail('Unsupported operating system!')
    }
  }
  file { $tempfile:
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
