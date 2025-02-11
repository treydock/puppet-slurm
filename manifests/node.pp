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
# @param restricted_cores_per_gpu
# @param sockets
# @param sockets_per_board
# @param state
# @param threads_per_core
# @param tmp_disk
# @param weight
# @param target
# @param order
#
define slurm::node (
  String[1] $node_name = $name,
  Optional[Stdlib::Host] $node_hostname = undef,
  Optional[Stdlib::IP::Address] $node_addr = undef,
  Optional[Stdlib::IP::Address] $bcast_addr = undef,
  Optional[Variant[String[1], Integer]] $boards = undef,
  Optional[Variant[String[1], Integer]] $core_spec_count  = undef,
  Optional[Variant[String[1], Integer]] $cores_per_socket = undef,
  Optional[Slurm::CPUBind] $cpu_bind = undef,
  Optional[Variant[String[1], Integer]] $cpus = undef,
  Optional[Variant[String[1], Array[String[1]]]] $cpu_spec_list = undef,
  Optional[Variant[String[1], Array[String[1]]]] $features = undef,
  Optional[Variant[String[1], Array[String[1]]]] $gres = undef,
  Optional[Variant[String[1], Integer]] $mem_spec_limit = undef,
  Optional[Stdlib::Port] $port = undef,
  Optional[Variant[String[1], Integer]] $real_memory = undef,
  Optional[String[1]] $reason = undef,
  Optional[Integer] $restricted_cores_per_gpu = undef,
  Optional[Variant[String[1], Integer]] $sockets = undef,
  Optional[Variant[String[1], Integer]] $sockets_per_board = undef,
  Slurm::NodeState $state = 'UNKNOWN',
  Optional[Variant[String[1], Integer]] $threads_per_core = undef,
  Optional[Integer] $tmp_disk = undef,
  Optional[Integer] $weight = undef,
  String[1] $target = 'slurm.conf',
  Variant[String[1], Integer] $order = '90',
) {
  include slurm

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
    'RestrictedCoresPerGPU' => $restricted_cores_per_gpu,
    'Sockets' => $sockets,
    'SocketsPerBoard' => $sockets_per_board,
    'State' => $state,
    'ThreadsPerCore'  => $threads_per_core,
    'TmpDisk' => $tmp_disk,
    'Weight' => $weight,
  }

  concat::fragment { "${target}-node-${name}":
    target  => $target,
    content => template($slurm::node_template),
    order   => $order,
  }
}
