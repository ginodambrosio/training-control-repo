class profile::windows::basics3 {
  user {'gino':
        name            => 'Gino DAmbrosio',
        ensure          => present,
        comment         => 'Legendary',
        groups          => [],
        membership      => inclusive,
        password        => 'Puppetlabs123',
    }
  group{'legends':
        name            => 'Legends',
        ensure          => present,
        members         => ['Gino DAmbrosio'],
    }
  file { 'c:/Users/gino':
  ensure => 'directory',
#  mode   => '0660',
#  owner  => 'Gino DAmbrosio',
#  group  => 'Legends',
    }
  acl { 'c:/Users/gino':
    permissions => [
     { identity => 'Gino DAmbrosio', rights => ['full'] },
     { identity => 'Legends', rights => ['read'] }
     ],
    }
}
