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
    ensure                 => absent,
#    installmanagementtools => true,
  }

  reboot {'after_Web-Server':
    when  => pending,
    subscribe => Windowsfeature['Web-Server'],
  }

  #iis_application_pool { 'minimal_site_app_pool':
    #ensure                  => 'present',
    #state                   => 'started',
    #managed_pipeline_mode   => 'Integrated',
    #managed_runtime_version => 'v4.0',
  #} ->

  #iis_site { 'minimal':
    #ensure          => 'started',
    #physicalpath    => 'c:\\inetpub\\minimal',
    #applicationpool => 'minimal_site_app_pool',
    #defaultpage     => 'index.htm',
    #require         => File['minimal'],
  #}

  #file { 'minimal':
    #ensure => 'directory',
    #path   => 'c:\\inetpub\\minimal',
  #}

}
