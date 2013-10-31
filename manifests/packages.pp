class resque_web::packages {
    package { 'ruby-devel':
        ensure  => installed,
    }

    package { ['resque', 'resque-scheduler']:
        ensure      => installed,
        provider    => 'gem',
        require     => Package['ruby-devel'],
    }
}