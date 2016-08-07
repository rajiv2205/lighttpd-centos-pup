#class { 'lighttpd': 
#	use_ssl => false
#}
#
#class { 'lighttpd::directories':
#	require => Class['lighttpd']
#}
include my-lighttpd
