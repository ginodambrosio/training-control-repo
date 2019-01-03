class role::windummy { 
  include profile::windows::basics3
  notify{"The myvar value is: ${myvar}": }
}
