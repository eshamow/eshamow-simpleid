# == Class: simpleid
#
# Installs SimpleID. This is a very naive PHP app installer that can optionally
# control Apache.
#
# === Parameters
#
# [*baseurl*]
#   The base URL for the OpenID domain to be managed
#
# [*webroot*]
#   Directory under which to place the simpleid directories. Defaults to the
#   parent directory of the OS native Apache webroot.
#
# [*webuser*]
#   User under which the webserver runs. Defaults to OS native for Apache
#
# [*webgroup*]
#   Group under which the webserver runs. Defaults to OS native for Apache
#
# [*app_source*]
#   Location of the SimpleID download tarball. Defaults to
#   http://downloads.sourceforge.net/project/simpleid/simpleid/0.8.5/simpleid-0.8.5.tar.gz
#
# [*manage_apache*]
#   Boolean to determine whether the module should install and configure Apache.
#   Defaults to true.
#
# === Examples
#
#  class { simpleid:
#    $baseurl = 'https://www.example.com',
#  }
#
# === Authors
#
# Eric Shamow <eric@puppetlabs.com>
#
# === Copyright
#
# Copyright 2014 Puppet Labs
#
class simpleid(
  $baseurl       = undef,
  $webroot       = $simpleid::params::webroot,
  $webuser       = $simpleid::params::webuser,
  $webgroup      = $simplid::params::webgroup,
  $app_source    = $simpleid::params::app_source,
  $manage_apache = true,
  $apache_ssl    = true
) inherits simpleid::params {
  if $baseurl == undef {
    fail('You must define the $baseurl variable for class simpleid.')
  }
  staging::file { 'simpleid.tar.gz':
    source => $app_source,
  }
  staging::extract { 'simpleid.tar.gz':
    target  => "${webroot}",
    creates => "${webroot}/simpleid",
    require => Staging::File['simpleid.tar.gz'],
  }
  file { "${webroot}/simpleid":
    ensure  => directory,
    owner   => $webuser,
    group   => $webgroup,
    mode    => '750',
    recurse => true,
    require => Staging::Extract['simpleid.tar.gz'],
  }
  if $manage_apache == true {
    class { 'apache':
      default_vhost => false,
    }
    class { 'apache::php': }
    apache::vhost { 'localhost_ssl':
      docroot => "${webroot}/simpleid/www",
      port    => '443',
      ssl     => true,
    }
    apache::vhost { 'localhost':
      docroot => "${webroot}/simpleid/www",
      port    => '80',
      ssl     => false,
    }
  }
  file { "${webroot}/simpleid/www/config.inc":
    owner => $webuser,
    group => $webgroup,
    mode  => '0750',
    content => template('simpleid/config.inc.erb'),
  }
}
