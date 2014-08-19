# == Defines jboss_admin::socket_binding_group
#
# Contains a list of socket configurations.
#
# === Parameters
#
# [*port_offset*]
#   Increment to apply to the base port values defined in the socket bindings to derive the runtime values to use on this server.
#
# [*default_interface*]
#   Name of an interface that should be used as the interface for any sockets that do not explicitly declare one.
#
# [*resource_name*]
#   The name of the socket binding group.
#
#
define jboss_admin::resource::socket_binding_group (
  $server,
  $port_offset                    = undef,
  $default_interface              = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $port_offset != undef and !is_integer($port_offset) { 
      fail('The attribute port_offset is not an integer') 
    }
  

    $raw_options = { 
      'port-offset'                  => $port_offset,
      'default-interface'            => $default_interface,
      'name'                         => $resource_name,
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