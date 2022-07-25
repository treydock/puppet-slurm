# @summary Manage Slurm main configuration
#
# @param configs
#   Hash of Slurm configs
# @param template
#   Template to use to generate slurm.conf contents
# @param source
#   Source of configuration instead of templated configs
# @param config_name
#   Name of configuration file
#
# @example Create /etc/slurm/slurm-ascend.conf
#
#  include slurm
#  $cluster_conf = {
#    'ClusterName'   => 'ascend',
#    'SlurmctldHost' => 'ascend-slurm01.example.com',
#  }
#  slurm::conf { 'ascend':
#    configs => $slurm::slurm_conf + $cluster_conf,
#  }
#
define slurm::conf (
  Hash $configs = {},
  Optional[String] $template = undef,
  Optional[String] $source = undef,
  String $config_name = "slurm-${name}.conf",
) {

  include slurm

  if $template {
    $_template = $template
  } else {
    $_template = $slurm::slurm_conf_template
  }
  if $source {
    $content = undef
  } else {
    $content = template($_template)
  }

  concat { $config_name:
    ensure => 'present',
    path   => "${slurm::conf_dir}/${config_name}",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => $slurm::service_notify,
  }

  concat::fragment { "${config_name}-config":
    target  => $config_name,
    content => $content,
    source  => $source,
    order   => '00',
  }

}
