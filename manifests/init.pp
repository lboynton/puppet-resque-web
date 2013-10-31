class resque_web {
	include redis

    package { ['resque', 'resque-scheduler']:
        ensure      => installed,
        provider    => 'gem',
    }

    file { '/root/resque-web.rb':
        mode    => 0755,
        source  => 'puppet:///modules/resque_web/resque-web.rb',
    }

    # start resque web interface
    exec { '/root/resque-web.rb -p 80':
        unless  => '/usr/bin/pgrep resque-web',
        require => [
            File['/root/resque-web.rb'],
            Service['redis'],
        ]
    }
}