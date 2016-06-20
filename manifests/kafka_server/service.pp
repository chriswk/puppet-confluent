class confluent::kafka_server::service (
  $daemonpath       = '/usr/bin',
  $configpath       = '/etc/kafka',
  $daemonname       = 'kafka-server',
  $propertyname     = 'server.properties',
  $pidpattern       = '[k]afkaServer',
  $kafka_opts       = $confluent::kafka_opts,
  $heap_opts        = $confluent::kafka_heap_opts,
) {

  file { '/etc/init.d/kafka-server':
    ensure  => file,
    mode    => '0755',    
    content => template('confluent/init.erb'),
    require => Package[ "confluent-kafka-${::confluent::scala_version}" ],
  }

  service { 'kafka-server':
    ensure   => running,
    enable   => true,
    require  => File['/etc/init.d/kafka-server'],
    provider => 'init',
  }

}
