class simpleid::params {
  $app_source = 'http://downloads.sourceforge.net/project/simpleid/simpleid/0.8.5/simpleid-0.8.5.tar.gz'
  case $::osfamily {
    'RedHat': {
      $webroot  = '/var/www'
      $webuser  = 'apache'
      $webgroup = 'apache'
    }
  }
}
