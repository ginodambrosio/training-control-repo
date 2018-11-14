class profile::lb_services::haproxy {

  include ::haproxy

  haproxy::listen { 'puppet':
    collect_exported => false,
    ipaddress        => '192.168.2.7',
    ports            => '8140',
  }

  haproxy::balancermember { 'compile master 1':
    listening_service => 'puppet',
    server_names      => 'compile-master-0.local',
    ipaddresses       => '192.168.2.5',
    ports             => '8140',
    options           => 'check',
  }

  haproxy::balancermember { 'compile master 2':
    listening_service => 'puppet',
    server_names      => 'compile-master-1.local',
    ipaddresses       => '192.168.2.6',
    ports             => '8140',
    options           => 'check'
  }
}
