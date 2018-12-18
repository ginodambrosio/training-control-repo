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

#  windowsfeature { 'Web-Server':
#    ensure                 => present,
#    installmanagementtools => true,
#  }

  #reboot {'after_Web-Server':
    #when  => pending,
    #subscribe => Windowsfeature['Web-Server'],
  #}

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

  $iis_features = ['Web-WebServer','Web-Scripting-Tools']

  iis_feature { $iis_features:
    ensure => 'present',
  }

  # Delete the default website to prevent a port binding conflict.
  iis_site {'Default Web Site':
    ensure  => absent,
    require => Iis_feature['Web-WebServer'],
  }

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

  #archive { 'C:/Windows/Temp/7z1805-x64.msi':
    #source => 'https://www.7-zip.org/a/7z1805-x64.msi',
  #}

  #class { 'archive':
    #seven_zip_name     => '7-Zip 18.05 (x64 edition)',
    #seven_zip_source   => 'C:/Windows/Temp/7z1805-x64.msi',
    #seven_zip_provider => 'windows',
  #}

  include chocolatey
  package { '7-Zip':
    ensure   => latest,
    provider => 'chocolatey',
  }

  archive { 'C:/Users/gino/putty-0.70.tar.gz':
    source        => 'http://mirror.internode.on.net/pub/putty/0.70/putty-0.70.tar.gz',
    extract       => true,
    extract_path  => "C:/Users/gino",
  }
  # Could not figure out how to gunzip and untar in one operation using 7zip, so extract tar after gunzip
  archive { 'C:/Users/gino/putty-0.70.tar':
    source        => 'C:/Users/gino/putty-0.70.tar',
    extract       => true,
    extract_path  => "C:/Users/gino",
    creates       => "C:/Users/gino/putty-0.70" #directory inside tgz
  }

}
