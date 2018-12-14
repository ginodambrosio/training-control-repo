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
        name            => 'legends',
        ensure          => absent,
        comment         => 'Hall of fame',
        members         => ['Gino DAmbrosio'],
    }
}
