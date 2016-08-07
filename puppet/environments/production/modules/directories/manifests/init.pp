
class directories {

  # create a directory      
  file { '/var/www/htdocs':
    ensure => ['directory','present'],
  }
  file { '/var/www/htdocs/index.html':
    ensure => 'file',
    source => "puppet:///modules/directories/index.html.inc",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
