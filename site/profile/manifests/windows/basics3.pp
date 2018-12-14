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
  mode   => '0660',
  owner  => 'gino',
  group  => 'Legends',
    }
}