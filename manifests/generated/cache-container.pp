# == Defines jboss_admin::cache-container
#
# The configuration of an infinispan cache container
#
# === Parameters
#
# [*default_cache*]
#   The default infinispan cache
#
# [*start*]
#   The cache container start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*aliases*]
#   The list of aliases for this cache container
#
# [*jndi_name*]
#   The jndi name to which to bind this cache container
#
# [*listener_executor*]
#   The executor used for the replication queue
#
# [*eviction_executor*]
#   The scheduled executor used for eviction
#
# [*replication_queue_executor*]
#   The executor used for asynchronous cache operations
#
#
define jboss_admin::cache-container (
  $server,
  $default_cache                  = undef,
  $start                          = undef,
  $aliases                        = undef,
  $jndi_name                      = undef,
  $listener_executor              = undef,
  $eviction_executor              = undef,
  $replication_queue_executor     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'default-cache'                => $default_cache,
      'start'                        => $start,
      'aliases'                      => $aliases,
      'jndi-name'                    => $jndi_name,
      'listener-executor'            => $listener_executor,
      'eviction-executor'            => $eviction_executor,
      'replication-queue-executor'   => $replication_queue_executor,
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