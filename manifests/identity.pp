define simpleid::identity(
  $username = undef
) {
  file { "/var/www/simpleid/identities/${username}.identity":
    owner => 'apache',
    group => 'apache',
    mode  => '0750',
    content => template('simpleid/username.identity.erb'),
  }
}
