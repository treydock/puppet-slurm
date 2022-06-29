# @summary Manage SLURM GRES configuration
#
# @example Add static GPU GRES
#   slurm::gres { 'gpu':
#     type  => 'v100',
#     file  => '/dev/nvidia0',
#     cores => '0,1',
#   }
#
# @example Add nvml AutoDetect gres
#   slurm::gres { 'nvml':
#     auto_detect => 'nvml',
#   }
#
#
# @param gres_name
# @param type
# @param node_name
# @param auto_detect
# @param count
# @param cores
# @param file
# @param flags
# @param links
# @param switch_name
# @param switches
# @param link_speed
# @param order
#
define slurm::gres (
  $gres_name = $name,
  $type = undef,
  $node_name = undef,
  Optional[Enum['nvml','rsmi']] $auto_detect = undef,
  $count = undef,
  $cores = undef,
  $file = undef,
  Optional[Enum['CountOnly']] $flags = undef,
  $links = undef,
  $switch_name = $name,
  $switches = undef,
  $link_speed = undef,
  $order = '50',
) {

  include ::slurm

  if $auto_detect {
    $conf_values = {
      'NodeName'   => $node_name,
      'AutoDetect' => $auto_detect,
    }
  } else {
    $conf_values = {
      'NodeName' => $node_name,
      'Name' => $gres_name,
      'Type' => $type,
      'AutoDetect' => $auto_detect,
      'Count' => $count,
      'Cores' => $cores,
      'File' => $file,
      'Flags' => $flags,
      'Links' => $links,
    }
  }

  concat::fragment { "slurm-gres.conf-${name}":
    target  => 'slurm-gres.conf',
    content => template($::slurm::gres_template),
    order   => $order,
  }

}
