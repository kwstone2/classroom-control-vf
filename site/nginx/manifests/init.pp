class nginx {
  package { 'nginx':
    ensure  => present,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    require => Package['nginx'],
    mode    => '0644',
    source  => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { '/var/www':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
  
  file { '/var/www/index.html':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nginx/default.conf',
  
  }
  
  service { 'nginx':
    subscribe => [File['/etc/nginx/nginx.conf'], File['/etc/nginx/nginx.conf']],
    ensure    => running,
    enable   => true,
  }
}
