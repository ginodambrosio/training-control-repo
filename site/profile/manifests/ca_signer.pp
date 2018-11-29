ini_setting { 'policy-based autosigning':
  setting => 'autosign',
  path    => "${confdir}/puppet.conf",
  section => 'master',
  value   => '/opt/puppetlabs/puppet/bin/autosign-validator',
  notify  => Service['pe-puppetserver'],
  }

class { ::autosign:
  ensure => 'latest',
  config => {
    'general' => {
      'loglevel' => 'INFO',
    },
    'jwt_token' => {
      'secret'   => 'puppetlabs'
      'validity' => '10800',
    }
  },
}
