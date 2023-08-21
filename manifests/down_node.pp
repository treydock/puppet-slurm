# @summary Manage SLURM down node configuration
#
#
#
#
# @param down_nodes
# @param reason
# @param state
# @param target
# @param order
#
define slurm::down_node (
  String $down_nodes = $name,
  Optional[String] $reason = undef,
  Slurm::DownNodeState $state = 'UNKNOWN',
  String $target = 'slurm.conf',
  String[1] $order = '75',
) {
  include slurm

  $content = "DownNodes=${down_nodes} State=${state} Reason=\"${reason}\"\n"

  concat::fragment { "${target}-downnode-${name}":
    target  => $target,
    content => $content,
    order   => $order,
  }
}
