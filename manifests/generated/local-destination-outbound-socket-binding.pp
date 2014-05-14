# == Defines jboss_admin::local-destination-outbound-socket-binding
#
# Configuration information for a, local destination, outbound socket binding.
#
# === Parameters
#
# [*fixed_source_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other outbound sockets in the socket group.
#
# [*socket_binding_ref*]
#   The name of the local socket-binding which will be used to determine the port to which this outbound socket connects.
#
# [*source_interface*]
#   The name of the interface which will be used for the source address of the outbound socket.
#
# [*source_port*]
#   The port number which will be used as the source port of the outbound socket.
#
#
define jboss_admin::local-destination-outbound-socket-binding (
  $server,
  $fixed_source_port              = undef,
  $socket_binding_ref             = undef,
  $source_interface               = undef,
  $source_port                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $source_port != undef && !is_integer($source_port) { 
      fail('The attribute source_port is not an integer') 
    }
  

    $raw_options = { 
      'fixed-source-port'            => $fixed_source_port,
      'socket-binding-ref'           => $socket_binding_ref,
      'source-interface'             => $source_interface,
      'source-port'                  => $source_port,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }

  }

  if $ensure == absent {
    jboss_resource { $path:
      ensure => $ensure,
      server => $server
    }
  }


}