class wrappers::epel {
  
  class { 'epel':
    epel_testing_enabled => '1',
  }

}
