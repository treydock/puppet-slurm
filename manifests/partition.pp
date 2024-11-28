# @summary Manage a SLURM partition configuration
#
#
#
# @param partition_name
# @param alloc_nodes
# @param allow_accounts
# @param allow_groups
# @param allow_qos
# @param alternate
# @param cpu_bind
# @param default
# @param def_cpu_per_gpu
# @param def_mem_per_cpu
# @param def_mem_per_gpu
# @param def_mem_per_node
# @param deny_accounts
# @param deny_qos
# @param default_time
# @param disable_root_jobs
# @param exclusive_topo
# @param exclusive_user
# @param grace_time
# @param hidden
# @param lln
# @param max_cpus_per_node
# @param max_mem_per_cpu
# @param max_mem_per_node
# @param max_nodes
# @param max_time
# @param min_nodes
# @param nodes
# @param over_subscribe
# @param over_time_limit
# @param preempt_mode
# @param priority_job_factor
# @param priority_tier
# @param qos
# @param req_resv
# @param resume_timeout
# @param root_only
# @param select_type_parameters
# @param shared
# @param state
# @param suspend_time
# @param suspend_timeout
# @param tres_billing_weights
# @param target
# @param order
#
define slurm::partition (
  String[1] $partition_name = $name,
  Optional[Variant[String[1], Array[String[1]]]] $alloc_nodes = undef,
  Optional[Variant[String[1], Array[String[1]]]] $allow_accounts = undef,
  Optional[Variant[String[1], Array[String[1]]]] $allow_groups = undef,
  Optional[Variant[String[1], Array[String[1]]]] $allow_qos = undef,
  Optional[String[1]] $alternate = undef,
  Optional[Slurm::CPUBind] $cpu_bind = undef,
  Optional[Slurm::YesNo] $default = undef,
  Optional[Variant[String[1], Integer]] $def_cpu_per_gpu = undef,
  Optional[Variant[String[1], Integer]] $def_mem_per_cpu = undef,
  Optional[Variant[String[1], Integer]] $def_mem_per_gpu = undef,
  Optional[Variant[String[1], Integer]] $def_mem_per_node = undef,
  Optional[Variant[String[1], Array[String[1]]]] $deny_accounts = undef,
  Optional[Variant[String[1], Array[String[1]]]] $deny_qos = undef,
  Optional[String[1]] $default_time = undef,
  Optional[Slurm::YesNo] $disable_root_jobs = undef,
  Optional[Slurm::YesNo] $exclusive_topo = undef,
  Optional[Slurm::YesNo] $exclusive_user = undef,
  Optional[Variant[String[1], Integer]] $grace_time = undef,
  Optional[Slurm::YesNo] $hidden = undef,
  Optional[Slurm::YesNo] $lln = undef,
  Optional[Variant[String[1], Integer]] $max_cpus_per_node = undef,
  Optional[Variant[String[1], Integer]] $max_mem_per_cpu = undef,
  Optional[Variant[String[1], Integer]] $max_mem_per_node = undef,
  Optional[Variant[String[1], Integer]] $max_nodes = undef,
  Optional[String[1]] $max_time = undef,
  Optional[Variant[String[1], Integer]] $min_nodes = undef,
  Optional[Variant[String[1], Array[String[1]]]] $nodes = undef,
  Optional[Enum['EXCLUSIVE','FORCE','YES','NO']] $over_subscribe = undef,
  Optional[Variant[String[1], Integer]] $over_time_limit = undef,
  Optional[Slurm::PreemptMode] $preempt_mode = undef,
  Optional[Variant[String[1], Integer]] $priority_job_factor = undef,
  Optional[Variant[String[1], Integer]] $priority_tier = undef,
  Optional[String[1]] $qos = undef,
  Optional[Slurm::YesNo] $req_resv = undef,
  Optional[Variant[String[1], Integer]] $resume_timeout = undef,
  Optional[Slurm::YesNo] $root_only = undef,
  Optional[Slurm::SelectTypeParameters] $select_type_parameters = undef,
  Optional[Enum['EXCLUSIVE','FORCE','YES','NO']] $shared = undef,
  Slurm::PartitionState $state = 'UP',
  Optional[Variant[String[1], Integer]] $suspend_time = undef,
  Optional[Variant[String[1], Integer]] $suspend_timeout = undef,
  Optional[Variant[String[1], Array[String[1]]]] $tres_billing_weights = undef,
  String[1] $target = 'slurm.conf',
  Variant[String[1], Integer] $order = '50',
) {
  include slurm

  $conf_values = {
    'PartitionName' => $partition_name,
    'AllocNodes' => $alloc_nodes,
    'AllowAccounts' => $allow_accounts,
    'AllowGroups' => $allow_groups,
    'AllowQos' => $allow_qos,
    'Alternate' => $alternate,
    'CpuBind' => $cpu_bind,
    'Default' => $default,
    'DefaultTime' => $default_time,
    'DefCpuPerGPU' => $def_cpu_per_gpu,
    'DefMemPerCPU' => $def_mem_per_cpu,
    'DefMemPerGPU' => $def_mem_per_gpu,
    'DefMemPerNode' => $def_mem_per_node,
    'DenyAccounts' => $deny_accounts,
    'DenyQos' => $deny_qos,
    'DisableRootJobs' => $disable_root_jobs,
    'ExclusiveTopo' => $exclusive_topo,
    'ExclusiveUser' => $exclusive_user,
    'GraceTime' => $grace_time,
    'Hidden' => $hidden,
    'LLN' => $lln,
    'MaxCPUsPerNode' => $max_cpus_per_node,
    'MaxMemPerCPU' => $max_mem_per_cpu,
    'MaxMemPerNode' => $max_mem_per_node,
    'MaxNodes' => $max_nodes,
    'MaxTime' => $max_time,
    'MinNodes' => $min_nodes,
    'Nodes' => $nodes,
    'OverSubscribe' => $over_subscribe,
    'OverTimeLimit' => $over_time_limit,
    'PreemptMode' => $preempt_mode,
    'PriorityJobFactor' => $priority_job_factor,
    'PriorityTier' => $priority_tier,
    'QOS' => $qos,
    'ReqResv' => $req_resv,
    'ResumeTimeout' => $resume_timeout,
    'RootOnly' => $root_only,
    'SelectTypeParameters' => $select_type_parameters,
    'Shared' => $shared,
    'State' => $state,
    'SuspendTime' => $suspend_time,
    'SuspendTimeout' => $suspend_timeout,
    'TRESBillingWeights' => $tres_billing_weights,
  }

  concat::fragment { "${target}-partition-${name}":
    target  => $target,
    content => template($slurm::partition_template),
    order   => $order,
  }
}
