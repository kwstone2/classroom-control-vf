class nginx (
   $pkgname   = $nginx::params::pkgname,
   $fileowner = $nginx::params::fileowner,
   $filegroup = $nginx::params::filegroup,
   $docroot   = $nginx::params::docroot,
   $configdir = $nginx::params::configdir,
   $srvblkdir = $nginx::params::srvblkdir,
   $logdir    = $nginx::params::logdir,
   $svcname   = $nginx::params::svcname
  ) inherits nginx::params
  {

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
