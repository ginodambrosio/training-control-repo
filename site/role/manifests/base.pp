class role::base { 
  include profile::hiera_test
#  notify{"myvar is: ${myvar} and environment is: $::environment": }
}
