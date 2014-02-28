# == Class: simpleid
#
# Full description of class simpleid here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { simpleid:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class simpleid(
  $baseurl  = undef,
  $webroot  = $simpleid::params::webroot,
  $webuser  = $simpleid::params::webuser,
  $webgroup = $simplid::params::webgroup,
) {
  if $baseurl == undef {
    fail('You must define the $baseurl variable for class simpleid.')
  }
  staging::file { 'simpleid.tar.gz':
    source => 'http://downloads.sourceforge.net/project/simpleid/simpleid/0.8.5/simpleid-0.8.5.tar.gz',
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
  class { 'apache':
    default_vhost => false,
  }
  class { 'apache::php': }
  apache::vhost { 'localhost':
    docroot => "${webroot}/simpleid/www",
    port    => '80',
  }
  file { "${webroot}/simpleid/www/config.inc":
    owner => $webuser,
    group => $webgroup,
    mode  => '0750',
    content => template('simpleid/config.inc.erb'),
  }
}
