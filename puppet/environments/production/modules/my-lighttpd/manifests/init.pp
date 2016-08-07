# == Class: lighttpd
#
# Full description of class lighttpd here.
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
#  class { 'lighttpd':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class my-lighttpd (

$tar_path = '/tmp',
$tar_file = 'lighttpd-1.4.41.tar.gz',
$lighttpd_path = '/tmp/lighttpd-1.4.41',
$data_dir = undef,
$server_root = undef,
) {

Exec {
                path => [
                        '/usr/local/bin',
                        '/opt/local/bin',
                        '/usr/bin',
                        '/usr/sbin',
                        '/bin',
                        '/sbin'],
                        logoutput => true
        }

package { 'pcre-devel':
	ensure => present
}

package { 'bzip2-devel':
	ensure => present
}

user { 'lighttpd':
	ensure => 'present',
	shell => '/sbin/nologin',
	}

file { "/$tar_path/lighttpd-1.4.41.tar.gz":
    ensure => 'file',
    source => "puppet:///modules/my-lighttpd/lighttpd-1.4.41.tar.gz.inc",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

exec { 'download_lighttpd':
	cwd => "$tar_path",
	command => "tar -xzvf lighttpd-1.4.41.tar.gz",
#	creates => "/tmp/lighttpd-1.4.41.tar.gz",
}

exec { 'install_lighttpd':
	require => Exec['download_lighttpd'],
	cwd => "$lighttpd_path",
	command => "$lighttpd_path/configure && make && make install && sed -e 's/FOO/lighttpd/g' doc/initscripts/rc.lighttpd.redhat > /etc/init.d/lighttpd && chmod a+rx /etc/init.d/lighttpd && cp -p doc/initscripts/sysconfig.lighttpd /etc/sysconfig/lighttpd && mkdir -p /etc/lighttpd && cp -R doc/config/conf.d/ doc/config/*.conf doc/config/vhosts.d/ /etc/lighttpd/ && ln -s /usr/local/sbin/lighttpd /usr/sbin/lighttpd",
#	creates => "/etc/init.d/lighttpd",
}

file { '/var/log/lighttpd':
    ensure => 'directory',
    owner  => 'lighttpd',
    group  => 'lighttpd',
  }

file { [ "${server_root}", "${data_dir}" ] :
    ensure => 'directory',
    owner  => 'lighttpd',
    group  => 'lighttpd',
  }

file { '/etc/lighttpd/lighttpd.conf':
    require => Exec['install_lighttpd'],
    ensure => 'file',
    content => template('my-lighttpd/lighttpd.conf.erb'),
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

file { "${data_dir}/index.html":
    ensure => 'file',
    source => "puppet:///modules/my-lighttpd/index.html.inc",
    owner  => 'lighttpd',
    group  => 'lighttpd',
    mode   => '0644',
  }

file { '/var/log/lighttpd/error.log':
    ensure => 'file',
    owner  => 'lighttpd',
    group  => 'lighttpd',
    mode   => '0644',
  }

file { '/var/log/lighttpd/access.log':
    ensure => 'file',
    owner  => 'lighttpd',
    group  => 'lighttpd',
    mode   => '0644',
  }

service { 'lighttpd':
    require => Exec['install_lighttpd'],
    ensure => running,
    enable => true,
}

}
