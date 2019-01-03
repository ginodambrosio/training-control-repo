class role::linuxdummy { 
  notify{"myvar is: ${myvar} and environment is: $::environment": }
}
