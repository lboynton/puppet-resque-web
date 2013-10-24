class resque_web {
	include redis
    package { 'resque':
        ensure      => installed,
        provider    => 'gem',
    }

    # start resque web interface
    exec { '/usr/bin/resque-web -p 80':
        unless  => '/usr/bin/pgrep resque-web',
        require => Service['redis'],
    }
}