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

  registry_value { 'HKLM\Software\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}\IsInstalled':
    ensure => present,
    type   => dword,
    data   => 1,
    }

  registry_value { 'HKLM\Software\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}\IsInstalled':
    ensure => present,
    type   => dword,
    data   => 1,
    }

  registry_value { 'HKLM\Software\Microsoft\Windows\CurrentVersion\Reliability\ShutdownReasonUI':
    ensure => present,
    type   => dword,
    data   => 1,
    }

  windowsfeature { 'Web-Server':
    ensure                 => present,
    installmanagementtools => true,
  }

  reboot {'after_Web-Server':
    when  => pending,
    subscribe => Windowsfeature['Web-Server'],
  }

  #$iis_features = ['Web-WebServer','Web-Scripting-Tools']

  #iis_feature { $iis_features:
    #ensure => 'present',
  #}

  # Delete the default website to prevent a port binding conflict.
  #iis_site {'Default Web Site':
    #ensure  => absent,
    #require => Iis_feature['Web-WebServer'],
  #}

  iis_site { 'minimal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\minimal',
    applicationpool => 'DefaultAppPool',
    require         => [
      File['minimal'],
      Iis_site['Default Web Site']
    ],
  }

  file { 'minimal':
    ensure => 'directory',
    path   => 'c:\\inetpub\\minimal',
  }

}
