class role::windummy { 
  include profile::windows::basics3
  notify{"myvar is: ${myvar} and environment is: $::environment": }
}
