# Puppet module: lighttpd

## DEPRECATION NOTICE
This module is no more actively maintained and will hardly be updated.

Please find an alternative module from other authors or consider [Tiny Puppet](https://github.com/example42/puppet-tp) as replacement.

If you want to maintain this module, contact [Alessandro Franceschi](https://github.com/alvagante)


This is a Puppet module for lighttpd based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alvagante / Example42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-lighttpd

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Basic management

* Install lighttpd with default settings

        class { 'lighttpd': }

* Install a specific version of lighttpd package

        class { 'lighttpd':
          version => '1.0.1',
        }

* Disable lighttpd service.

        class { 'lighttpd':
          disable => true
        }

* Remove lighttpd package

        class { 'lighttpd':
          absent => true
        }

* Enable auditing without without making changes on existing lighttpd configuration files

        class { 'lighttpd':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'lighttpd':
          source => [ "puppet:///modules/lab42/lighttpd/lighttpd.conf-${hostname}" , "puppet:///modules/lab42/lighttpd/lighttpd.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'lighttpd':
          source_dir       => 'puppet:///modules/lab42/lighttpd/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'lighttpd':
          template => 'example42/lighttpd/lighttpd.conf.erb',
        }

* Automatically include a custom subclass

        class { 'lighttpd':
          my_class => 'lighttpd::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'lighttpd':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'lighttpd':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'lighttpd':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'lighttpd':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }

