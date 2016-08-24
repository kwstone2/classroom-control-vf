class skeleton {
   file {
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
   }
   
   file { '/etc/skel/.bashrc':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
   }
   ->
   file { 'bashrc':
      path    => '/etc/skel/.bashrc',
      source  => 'puppet:///modules/skeleton/bashrc',
   }
}
