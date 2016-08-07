# = Define: lighttpd::dotconf
#
# General lighttpd define to be used to create generic custom .conf files 
# Very simple wrapper to a normal file type
# Use source or template to define the source
#
# == Parameters
#
# [*source*]
#   Sets the content of source parameter for the dotconf file
#   If defined, lighttpd dotconf file will have the param: source => $source
#
# [*template*]
#   Sets the path to the template to use as content for dotconf file
#   If defined, lighttpd dotconf file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*ensure*]
#   Define if you want to set this configuration. Default => present.
#   Set ensure => absent to remove a previously installed file
#
# == Usage
# lighttpd::dotconf { "sarg": source => 'puppet://$servername/sarg/sarg.conf' }
# or
# lighttpd::dotconf { "trac": content => 'template("trac/lighttpd.conf.erb")' }
#
define lighttpd::dotconf (
  $source   = '' ,
  $template = '' ,
  $ensure   = 'present' ) {

  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  $manage_file_content = $template ? {
    ''        => undef,
    default   => template($template),
  }

  include lighttpd

  file { "Lighttpd_${name}.conf":
    ensure  => $ensure,
    path    => "${lighttpd::config_dir}/${name}.conf",
    mode    => $lighttpd::config_file_mode,
    owner   => $lighttpd::config_file_owner,
    group   => $lighttpd::config_file_group,
    require => Package['lighttpd'],
    notify  => $lighttpd::manage_service_autorestart,
    source  => $manage_file_source,
    content => $manage_file_content,
    audit   => $lighttpd::manage_audit,
  }

}
