# Class: lighttpd::params
#
# This class defines default parameters used by the main module class lighttpd
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to lighttpd class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class lighttpd::params {

  ### Module specific parameters
  $use_ssl = false

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'lighttpd',
  }

  $service = $::operatingsystem ? {
    default => 'lighttpd',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'lighttpd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'www-data',
    default                   => 'lighttpd',
  }

  $config_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/lighttpd/conf-enabled',
    default                   => '/etc/lighttpd/conf.d',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/lighttpd/lighttpd.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/lighttpd',
    default                   => '/etc/sysconfig/lighttpd',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/run/lighttpd.pid',
    default                   => '/var/run/lighttpd/lighttpd.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/var/www',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/lighttpd',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/lighttpd/lighttpd.log',
  }


  $port = '80'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
