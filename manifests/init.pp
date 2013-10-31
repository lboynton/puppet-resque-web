class resque_web(
    $port   = 80
) {
    include redis
    require resque_web::packages

    file { '/root/resque-web.rb':
        mode    => 0755,
        source  => 'puppet:///modules/resque_web/resque-web.rb',
    }

    # start resque web interface
    exec { "/root/resque-web.rb -p ${port}":
        unless  => '/usr/bin/pgrep -f resque-web',
        require => [
            File['/root/resque-web.rb'],
            Service['redis'],
        ]
    }
}