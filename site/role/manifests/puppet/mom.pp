class role::puppet::mom {
  include profile::hiera_test
  include profile::puppet::ca_signer
  include profile::puppet::tunnel
#  notify{"myvar is: ${myvar} and environment is: $::environment": }
}
