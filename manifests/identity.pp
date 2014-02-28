define simpleid::identity(
  $username = $name,
  $password = undef
) {
  if $password == undef {
    fail("You must define a password for simpleid::identity ${username}.")
  }
  file { "/var/www/simpleid/identities/${username}.identity":
    owner => 'apache',
    group => 'apache',
    mode  => '0750',
    content => template('simpleid/username.identity.erb'),
  }
}
