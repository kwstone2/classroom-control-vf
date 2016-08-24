class nginx {
  package { 'nginx':
    ensure  => present,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    owner   => ,
    group   => ,
    require => Package['nginx'],
    mode    => '0644',
  }
  
  service { 'nginx':
    subscribe => File['/etc/nginx/nginx.conf'],
    ensure    => running,
    enable   => true,
  }
}
