class nginx {

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    ensure => file,
  }

  package { 'nginx':
    ensure  => present,
  }

  file { '/etc/nginx/nginx.conf':
    require => Package['nginx'],
    source  => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { '/var/www':
    ensure  => directory,
    mode    => '0755',
  }
  
  file { '/var/www/index.html':
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    source  => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    subscribe => [File['/etc/nginx/nginx.conf'], File['/etc/nginx/nginx.conf']],
    ensure    => running,
    enable   => true,
  }
}
