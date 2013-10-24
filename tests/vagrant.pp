include resque_web

service { 'iptables':
    ensure  => stopped,
    enable  => false,
}