class nginx (
  $root = undef,
  )
  {

  case $::os['family'] {
    'redhat', 'debian' : {
      $pkgname   = 'nginx'
      $fileowner = 'root'
      $filegroup = 'root'
      $def_docroot  = '/var/www'
      $configdir = '/etc/nginx'
      $srvblkdir = '/etc/nginx/conf.d'
      $logdir    = '/var/log/nginx'
      $svcname   = 'nginx'
    }
    'windows' : {
      $pkgname   = 'nginx-service'
      $fileowner = 'Administrator'
      $filegroup = 'Administrators'
      $def_docroot  = 'C:/ProgramData/nginx/html'
      $configdir = 'C:/ProgramData/nginx'
      $srvblkdir = 'C:/ProgramData/nginx/conf.d'
      $logdir    = 'C:/ProgramData/nginx/logs'
      $runsas    = 'nobody'
      $svcname   = 'nginx' 
    }
    default : {
      fail("Module ${module_name} is not supported on ${os['family']}" )
    }
  }

  $runsas = $::os['family'] ? {
    'RedHat' => 'nginx',
    'Debian' => 'www-data',
  }

  $docroot = $root ? {
    undef   => $def_docroot,
    default => $root,
  }

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    ensure => file,
  }

  package { $pkgname:
    ensure  => present,
  }

  file { "${configdir}/nginx.conf":
    require => Package[$pkgname],
    source  => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { $docroot:
    ensure  => directory,
    mode    => '0755',
  }
  
  file { "${docroot}/index.html":
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${srvblkdir}/default.conf":
    source  => 'puppet:///modules/nginx/default.conf',
  }
  
  service { $svcname:
    subscribe => [File["${configdir}/nginx.conf"], File["${srvblkdir}/default.conf"]],
    ensure    => running,
    enable   => true,
  }
}
