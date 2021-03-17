# @summary Manage SLURM SPANK plugin
#
# @param ensure
#   Ensure state of SPANK plugin
# @param plugin
#   The shared library
# @param arguments
#   Arguments for the plugin
# @param required
#   Is this plugin required?
# @param manage_package
#   Manage plugin package?
# @param package_name
#   Plugin package name
# @param package_ensure
#   Plugin package ensure value
# @param order
#   Order in plugstack.conf
#
define slurm::spank (
  Enum['present','absent'] $ensure = 'present',
  String $plugin = "${name}.so",
  Optional[Variant[Hash, Array, String]] $arguments = undef,
  Boolean $required = false,
  Boolean $manage_package = true,
  String $package_name = "slurm-spank-${name}",
  String $package_ensure = 'installed',
  $order = '50',
) {

  include slurm

  if $slurm::repo_baseurl {
    $package_require = Yumrepo['slurm']
  } else {
    $package_require = undef
  }

  if $ensure == 'absent' {
    $_package_ensure = 'absent'
  } else {
    $_package_ensure = $package_ensure
  }

  if $manage_package {
    $fragment_require = Package["SLURM SPANK ${name} package"]
    package { "SLURM SPANK ${name} package":
      ensure  => $_package_ensure,
      name    => $package_name,
      notify  => $slurm::service_notify,
      require => $package_require,
    }
  } else {
    $fragment_require = undef
  }

  if $ensure == 'present' and $slurm::manage_slurm_conf and ! $slurm::configless {
    concat::fragment { "plugstack.conf-${name}":
      target  => 'plugstack.conf',
      content => template('slurm/spank/plugin.conf.erb'),
      order   => $order,
      require => $fragment_require,
    }
  }

}
