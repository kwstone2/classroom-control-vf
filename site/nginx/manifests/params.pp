class nginx::params {

  case $::os['family'] {
    'redhat', 'debian' : {
      $pkgname   = 'nginx'
      $fileowner = 'root'
      $filegroup = 'root'
      $docroot  = '/var/www'
      $configdir = '/etc/nginx'
      $srvblkdir = '/etc/nginx/conf.d'
      $logdir    = '/var/log/nginx'
      $svcname   = 'nginx'
    }
    'windows' : {
      $pkgname   = 'nginx-service'
      $fileowner = 'Administrator'
      $filegroup = 'Administrators'
      $docroot  = 'C:/ProgramData/nginx/html'
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

}
