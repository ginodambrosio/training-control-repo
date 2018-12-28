class role::puppet::mom {
  include profile::puppet::ca_signer
  include profile::puppet::tunnel
  notify{"The myvar value is: ${myvar}": }
}
