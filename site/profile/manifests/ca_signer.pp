class profile::ca_signer {

include ::autosign

ini_setting { 'policy-based autosigning':
  setting => 'autosign',
  path    => "${confdir}/puppet.conf",
  section => 'master',
  value   => '/opt/puppetlabs/puppet/bin/autosign-validator',
  notify  => Service['pe-puppetserver'],
  }
}
