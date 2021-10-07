# @summary Manage SLURM node configuration
#
#
#
# @param node_name
# @param node_hostname
# @param node_addr
# @param bcast_addr
# @param boards
# @param core_spec_count
# @param cores_per_socket
# @param cpu_bind
# @param cpus
# @param cpu_spec_list
# @param features
# @param gres
# @param mem_spec_limit
# @param port
# @param real_memory
# @param reason
# @param sockets
# @param sockets_per_board
# @param state
# @param threads_per_core
# @param tmp_disk
# @param tres_weights
# @param weight
# @param order
#
define slurm::node (
  $node_name        = $name,
  $node_hostname    = undef,
  $node_addr        = undef,
  $bcast_addr       = undef,
  $boards           = undef,
  $core_spec_count  = undef,
  $cores_per_socket = undef,
  $cpu_bind         = undef,
  $cpus             = undef,
  $cpu_spec_list    = undef,
  $features         = undef,
  $gres             = undef,
  $mem_spec_limit   = undef,
  $port             = undef,
  $real_memory      = undef,
  $reason           = undef,
  $sockets          = undef,
  $sockets_per_board = undef,
  Slurm::NodeState $state = 'UNKNOWN',
  $threads_per_core = undef,
  Optional[Integer] $tmp_disk = undef,
  $tres_weights     = undef,
  Optional[Integer] $weight = undef,
  $order            = '90',
) {

  include ::slurm

  $conf_values = {
    'NodeName' => $node_name,
    'NodeHostname' => $node_hostname,
    'NodeAddr'  => $node_addr,
    'BcastAddr' => $bcast_addr,
    'Boards'  => $boards,
    'CoreSpecCount' => $core_spec_count,
    'CoresPerSocket' => $cores_per_socket,
    'CpuBind' => $cpu_bind,
    'CPUs'  => $cpus,
    'CpuSpecList' => $cpu_spec_list,
    'Features' => $features,
    'Gres'  => $gres,
    'MemSpecLimit'  => $mem_spec_limit,
    'Port'  => $port,
    'RealMemory'  => $real_memory,
    'Reason' => $reason,
    'Sockets' => $sockets,
    'SocketsPerBoard' => $sockets_per_board,
    'State' => $state,
    'ThreadsPerCore'  => $threads_per_core,
    'TmpDisk' => $tmp_disk,
    'TRESWeights' => $tres_weights,
    'Weight' => $weight,
  }

  concat::fragment { "slurm.conf-node-${name}":
    target  => 'slurm.conf',
    content => template($::slurm::node_template),
    order   => $order,
  }

}
