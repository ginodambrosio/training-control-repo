class profile::puppet::tunnel {
  #class { 'ngrok':
    #authtoken       => '84fAzMWrconh6dpfd1kRb_3DBPbRkWkNPYjiBNQUYYQ',
  #}
  include ngrok
  ngrok::tunnel { 'webhook':
    proto => 'tcp',
    addr  => '8170',
  }
}
