#modulename

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [eshamow-simpleid]](#setup)
    * [What [eshamow-simpleid] affects](#what-[eshamow-simpleid]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [eshamow-simpleid]](#beginning-with-[eshamow-simpleid])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Module to install/manage simpleid. Currently installs Apache+PHP for using puppetlabs-apache.

##Module Description

Module to install/manage simpleid. Currently installs Apache+PHP for using puppetlabs-apache.

IMPORTANT NOTE: This module currently sets up Apache to serve the password login page via HTTPS,
then the actual authentication over HTTP, as OpenID does not support self-signed certs. If you
want a more secure setup or your own certs, please set $manage_apache to false and set up your
own webserver config.

Currently supported:

RHEL 6

Future support:

RHEL 5
Debian 6 and 7
Ubuntu 12.04

##Setup

###What [eshamow-simpleid] affects

* By default, downloads simpleid package
* Uses nanliu-staging to expand this archive into a parameterized path
* Drops conf files in Apache fragments dir and can generate identity files under simpleid/identities directory

###Setup Requirements

* Expects puppetlabs-apache and nanliu-staging
* Nothing about this other than convention makes it Apache-only - would be easy to put in conditionals/support/templates for other webservers

###Beginning with [eshamow-simpleid]

Classify node with simpleid

##Limitations

RHEL or CentOS 6 only

