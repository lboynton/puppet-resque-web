class resque_web {
	include redis

    package { 'ruby-devel':
        ensure  => installed,
    }

    package { ['resque', 'resque-scheduler']:
        ensure      => installed,
        provider    => 'gem',
        require     => Package['ruby-devel'],
    }

    file { '/root/resque-web.rb':
        mode    => 0755,
        source  => 'puppet:///modules/resque_web/resque-web.rb',
    }

    # start resque web interface
    exec { '/root/resque-web.rb -p 80':
        unless  => '/usr/bin/pgrep -f resque-web',
        require => [
            File['/root/resque-web.rb'],
            Service['redis'],
        ]
    }
}