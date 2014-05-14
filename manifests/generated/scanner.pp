# == Defines jboss_admin::scanner
#
# The configuration of the deployment scanner subsystem
#
# === Parameters
#
# [*relative_to*]
#   Reference to a filesystem path defined in the "paths" section of the server configuration.
#
# [*deployment_timeout*]
#   Timeout, in seconds, a deployment is allows to execute before being canceled.  The default is 60 seconds.
#
# [*auto_deploy_exploded*]
#   Controls whether zipped deployment content should be automatically deployed by the scanner without requiring the user to add a .dodeploy marker file. Setting this to 'true' is not recommended for anything but basic development scenarios,  as there is no way to ensure that deployment will not occur in the middle of changes to the content.
#
# [*auto_deploy_xml*]
#   Controls whether XML deployment content should be automatically deployed by the scanner without requiring the user to add a .dodeploy marker file.
#
# [*scan_enabled*]
#   Flag indicating that all scanning (including initial scanning at startup) should be disabled.
#
# [*scan_interval*]
#   Periodic interval, in milliseconds, at which the repository should be scanned for changes. A value of less than 1 indicates the repository should only be scanned at initial startup.
#
# [*path*]
#   The actual filesystem path to be scanned. Treated as an absolute path, unless the 'relative-to' attribute is specified, in which case the value is treated as relative to that path.
#
# [*auto_deploy_zipped*]
#   Controls whether zipped deployment content should be automatically deployed by the scanner without requiring the user to add a .dodeploy marker file.
#
#
define jboss_admin::scanner (
  $server,
  $relative_to                    = undef,
  $deployment_timeout             = undef,
  $auto_deploy_exploded           = undef,
  $auto_deploy_xml                = undef,
  $scan_enabled                   = undef,
  $scan_interval                  = undef,
  $path                           = undef,
  $auto_deploy_zipped             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $scan_interval != undef && !is_integer($scan_interval) { 
      fail('The attribute scan_interval is not an integer') 
    }
  

    $raw_options = { 
      'relative-to'                  => $relative_to,
      'deployment-timeout'           => $deployment_timeout,
      'auto-deploy-exploded'         => $auto_deploy_exploded,
      'auto-deploy-xml'              => $auto_deploy_xml,
      'scan-enabled'                 => $scan_enabled,
      'scan-interval'                => $scan_interval,
      'path'                         => $path,
      'auto-deploy-zipped'           => $auto_deploy_zipped,
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