class basics3 {
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
        ensure          => present,
        members         => ['Gino DAmbrosio'],
    }
}
