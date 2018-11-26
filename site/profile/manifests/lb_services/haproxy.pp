class profile::lb_services::haproxy {

  include ::haproxy

  haproxy::listen { 'puppet':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '8140',
  }

  haproxy::balancermember { 'compile master 1':
    listening_service => 'puppet',
    server_names      => 'pe-201900-compile-1.puppetdebug.vlan',
    ipaddresses       => '192.168.0.8',
    ports             => '8140',
    options           => 'check',
  }

  haproxy::balancermember { 'compile master 2':
    listening_service => 'puppet',
    server_names      => 'pe-201900-compile-2.puppetdebug.vlan',
    ipaddresses       => '192.168.0.10',
    ports             => '8140',
    options           => 'check'
  }
}
