class skeleton {
   file { '/etc/skel':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
   }
   
   file { '/etc/skel/.bashrc':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
   }
   ->
   file_line { 'Append to skel .bashrc':
      path    => '/etc/skel/.bashrc',
      line    => '/bin/echo I'm skeleton in the closet',
   }
}
