# @summary Add switch to topology.conf
#
# @example
#   slurm::switch { 'switch1':
#     switches => 'switch[2-3],
#   }
#   slurm::switch { 'switch2':
#     nodes => 'c0[1-2]',
#   }
#
# @param switch_name = $name,
#   SwitchName value, see man page for topology.conf
# @param switches = undef,
#   Switches value, see man page for topology.conf
# @param nodes = undef,
#   Nodes value, see man page for topology.conf
# @param link_speed = undef,
#   LinkSpeed value, see man page for topology.conf
# @param order = '50',
#   Order inside topology.conf
#
define slurm::switch (
  String[1] $switch_name = $name,
  Optional[String[1]] $switches = undef,
  Optional[String[1]] $nodes = undef,
  Optional[String[1]] $link_speed = undef,
  Variant[String[1], Integer] $order = '50',
) {
  if ! $nodes and ! $switches {
    fail('slurm::switch: Must define either nodes or switches')
  }

  include slurm

  $conf_values = {
    'SwitchName' => $switch_name,
    'Switches' => $switches,
    'Nodes' => $nodes,
    'LinkSpeed' => $link_speed,
  }

  concat::fragment { "slurm-topology.conf-${name}":
    target  => 'slurm-topology.conf',
    content => template($slurm::switch_template),
    order   => $order,
  }
}
