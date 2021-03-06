# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

_Public Classes_

* [`slurm`](#slurm): Manage SLURM

_Private Classes_

* `slurm::client`: 
* `slurm::common::config`: 
* `slurm::common::install`: 
* `slurm::common::install::rpm`: 
* `slurm::common::install::source`: 
* `slurm::common::setup`: 
* `slurm::common::user`: 
* `slurm::params`: 
* `slurm::resources`: Manage SLURM resources using Puppet types
* `slurm::slurmctld`: 
* `slurm::slurmctld::config`: 
* `slurm::slurmctld::service`: 
* `slurm::slurmd`: 
* `slurm::slurmd::config`: 
* `slurm::slurmd::service`: 
* `slurm::slurmdbd`: 
* `slurm::slurmdbd::config`: 
* `slurm::slurmdbd::db`: 
* `slurm::slurmdbd::service`: 
* `slurm::slurmrestd`: 
* `slurm::slurmrestd::config`: 
* `slurm::slurmrestd::service`: 

**Defined types**

* [`slurm::down_node`](#slurmdown_node): Manage SLURM down node configuration
* [`slurm::gres`](#slurmgres): Manage SLURM GRES configuration
* [`slurm::node`](#slurmnode): Manage SLURM node configuration
* [`slurm::nodeset`](#slurmnodeset): Manage SLURM nodeset configuration
* [`slurm::partition`](#slurmpartition): Manage a SLURM partition configuration
* [`slurm::spank`](#slurmspank): Manage SLURM SPANK plugin
* [`slurm::switch`](#slurmswitch): Add switch to topology.conf

**Data types**

* [`Slurm::DownNodeState`](#slurmdownnodestate): 
* [`Slurm::NodeState`](#slurmnodestate): 
* [`Slurm::PartitionState`](#slurmpartitionstate): 
* [`Slurm::PreemptMode`](#slurmpreemptmode): 
* [`Slurm::SelectTypeParameters`](#slurmselecttypeparameters): 

**Tasks**

* [`reconfig`](#reconfig): Execute 'scontrol reconfig'

## Classes

### slurm

Roles

#### Parameters

The following parameters are available in the `slurm` class.

##### `slurmd`

Data type: `Boolean`



Default value: `false`

##### `slurmctld`

Data type: `Boolean`



Default value: `false`

##### `slurmdbd`

Data type: `Boolean`



Default value: `false`

##### `database`

Data type: `Boolean`



Default value: `false`

##### `client`

Data type: `Boolean`



Default value: `true`

##### `slurmrestd`

Data type: `Boolean`



Default value: `false`

##### `repo_baseurl`

Data type: `Optional[Variant[Stdlib::HTTPSUrl, Stdlib::HTTPUrl, Pattern[/^file:\/\//]]]`



Default value: `undef`

##### `install_method`

Data type: `Optional[Enum['package','source']]`



Default value: `undef`

##### `install_prefix`

Data type: `Stdlib::Absolutepath`



Default value: '/usr'

##### `version`

Data type: `String`



Default value: 'present'

##### `install_torque_wrapper`

Data type: `Boolean`



Default value: `false`

##### `install_pam`

Data type: `Boolean`



Default value: `true`

##### `source_dependencies`

Data type: `Array`



Default value: []

##### `configure_flags`

Data type: `Array`



Default value: []

##### `source_install_manage_alternatives`

Data type: `Boolean`



Default value: `true`

##### `slurmd_service_ensure`

Data type: `Enum['running','stopped']`



Default value: 'running'

##### `slurmd_service_enable`

Data type: `Boolean`



Default value: `true`

##### `slurmd_service_limits`

Data type: `Hash`



Default value: {}

##### `slurmd_options`

Data type: `String`



Default value: ''

##### `slurmctld_service_ensure`

Data type: `Enum['running','stopped']`



Default value: 'running'

##### `slurmctld_service_enable`

Data type: `Boolean`



Default value: `true`

##### `slurmctld_service_limits`

Data type: `Hash`



Default value: {}

##### `slurmctld_options`

Data type: `String`



Default value: ''

##### `slurmdbd_service_ensure`

Data type: `Enum['running','stopped']`



Default value: 'running'

##### `slurmdbd_service_enable`

Data type: `Boolean`



Default value: `true`

##### `slurmdbd_service_limits`

Data type: `Hash`



Default value: {}

##### `slurmdbd_options`

Data type: `String`



Default value: ''

##### `slurmctld_restart_on_failure`

Data type: `Boolean`



Default value: `true`

##### `slurmdbd_restart_on_failure`

Data type: `Boolean`



Default value: `true`

##### `reload_services`

Data type: `Boolean`



Default value: `true`

##### `restart_services`

Data type: `Boolean`



Default value: `false`

##### `manage_slurm_user`

Data type: `Any`



Default value: `true`

##### `slurm_user_group`

Data type: `Any`



Default value: 'slurm'

##### `slurm_group_gid`

Data type: `Any`



Default value: `undef`

##### `slurm_user`

Data type: `Any`



Default value: 'slurm'

##### `slurm_user_uid`

Data type: `Any`



Default value: `undef`

##### `slurm_user_comment`

Data type: `Any`



Default value: 'SLURM User'

##### `slurm_user_home`

Data type: `Any`



Default value: '/var/lib/slurm'

##### `slurm_user_managehome`

Data type: `Any`



Default value: `true`

##### `slurm_user_shell`

Data type: `Any`



Default value: '/sbin/nologin'

##### `slurmd_user`

Data type: `Any`



Default value: 'root'

##### `slurmd_user_group`

Data type: `Any`



Default value: 'root'

##### `manage_slurm_conf`

Data type: `Any`



Default value: `true`

##### `manage_scripts`

Data type: `Any`



Default value: `true`

##### `manage_firewall`

Data type: `Any`



Default value: `true`

##### `use_syslog`

Data type: `Any`



Default value: `false`

##### `manage_logrotate`

Data type: `Any`



Default value: `true`

##### `manage_rsyslog`

Data type: `Any`



Default value: `true`

##### `manage_database`

Data type: `Any`



Default value: `true`

##### `export_database`

Data type: `Any`



Default value: `false`

##### `export_database_tag`

Data type: `Any`



Default value: $facts['domain']

##### `cli_filter_lua_source`

Data type: `Any`



Default value: `undef`

##### `cli_filter_lua_content`

Data type: `Any`



Default value: `undef`

##### `state_dir_nfs_device`

Data type: `Any`



Default value: `undef`

##### `state_dir_nfs_options`

Data type: `Any`



Default value: 'rw,sync,noexec,nolock,auto'

##### `job_checkpoint_dir_nfs_device`

Data type: `Any`



Default value: `undef`

##### `job_checkpoint_dir_nfs_options`

Data type: `Any`



Default value: 'rw,sync,noexec,nolock,auto'

##### `job_submit_lua_source`

Data type: `Any`



Default value: `undef`

##### `job_submit_lua_content`

Data type: `Any`



Default value: `undef`

##### `cluster_name`

Data type: `Any`



Default value: 'linux'

##### `slurmctld_host`

Data type: `Variant[Array, String]`



Default value: 'slurm'

##### `slurmdbd_host`

Data type: `Any`



Default value: 'slurmdbd'

##### `conf_dir`

Data type: `Stdlib::Absolutepath`



Default value: '/etc/slurm'

##### `log_dir`

Data type: `Stdlib::Absolutepath`



Default value: '/var/log/slurm'

##### `spank_plugins`

Data type: `Hash`



Default value: {}

##### `configless`

Data type: `Boolean`



Default value: `false`

##### `conf_server`

Data type: `Optional[String]`



Default value: `undef`

##### `slurm_conf_override`

Data type: `Any`



Default value: {}

##### `slurm_conf_template`

Data type: `Any`



Default value: 'slurm/slurm.conf/slurm.conf.erb'

##### `slurm_conf_source`

Data type: `Any`



Default value: `undef`

##### `partition_template`

Data type: `Any`



Default value: 'slurm/slurm.conf/conf_values.erb'

##### `partition_source`

Data type: `Any`



Default value: `undef`

##### `node_template`

Data type: `Any`



Default value: 'slurm/slurm.conf/conf_values.erb'

##### `node_source`

Data type: `Any`



Default value: `undef`

##### `switch_template`

Data type: `Any`



Default value: 'slurm/slurm.conf/conf_values.erb'

##### `topology_source`

Data type: `Any`



Default value: `undef`

##### `gres_template`

Data type: `Any`



Default value: 'slurm/slurm.conf/conf_values.erb'

##### `gres_source`

Data type: `Any`



Default value: `undef`

##### `partitions`

Data type: `Any`



Default value: {}

##### `nodes`

Data type: `Any`



Default value: {}

##### `nodesets`

Data type: `Any`



Default value: {}

##### `switches`

Data type: `Any`



Default value: {}

##### `greses`

Data type: `Any`



Default value: {}

##### `slurmd_log_file`

Data type: `Optional[Stdlib::Absolutepath]`



Default value: `undef`

##### `slurmd_spool_dir`

Data type: `Any`



Default value: '/var/spool/slurmd'

##### `job_checkpoint_dir`

Data type: `Any`



Default value: '/var/spool/slurmctld.checkpoint'

##### `slurmctld_log_file`

Data type: `Optional[Stdlib::Absolutepath]`



Default value: `undef`

##### `state_save_location`

Data type: `Any`



Default value: '/var/spool/slurmctld.state'

##### `slurmdbd_archive_dir`

Data type: `Stdlib::Absolutepath`



Default value: '/var/lib/slurmdbd.archive'

##### `slurmdbd_log_file`

Data type: `Optional[Stdlib::Absolutepath]`



Default value: `undef`

##### `slurmdbd_storage_host`

Data type: `Any`



Default value: 'localhost'

##### `slurmdbd_storage_loc`

Data type: `Any`



Default value: 'slurm_acct_db'

##### `slurmdbd_storage_pass`

Data type: `Any`



Default value: 'slurmdbd'

##### `slurmdbd_storage_port`

Data type: `Any`



Default value: '3306'

##### `slurmdbd_storage_type`

Data type: `Any`



Default value: 'accounting_storage/mysql'

##### `slurmdbd_storage_user`

Data type: `Any`



Default value: 'slurmdbd'

##### `slurmdbd_conf_override`

Data type: `Any`



Default value: {}

##### `slurmdbd_archive_dir_nfs_device`

Data type: `Any`



Default value: `undef`

##### `slurmdbd_archive_dir_nfs_options`

Data type: `Any`



Default value: 'rw,sync,noexec,nolock,auto'

##### `use_nhc`

Data type: `Any`



Default value: `false`

##### `include_nhc`

Data type: `Any`



Default value: `false`

##### `health_check_program`

Data type: `Any`



Default value: `undef`

##### `health_check_program_source`

Data type: `Any`



Default value: `undef`

##### `manage_epilog`

Data type: `Any`



Default value: `true`

##### `epilog`

Data type: `Any`



Default value: `undef`

##### `epilog_source`

Data type: `Any`



Default value: `undef`

##### `epilog_sourceselect`

Data type: `Any`



Default value: `undef`

##### `manage_prolog`

Data type: `Any`



Default value: `true`

##### `prolog`

Data type: `Any`



Default value: `undef`

##### `prolog_source`

Data type: `Any`



Default value: `undef`

##### `prolog_sourceselect`

Data type: `Any`



Default value: `undef`

##### `manage_task_epilog`

Data type: `Any`



Default value: `true`

##### `task_epilog`

Data type: `Any`



Default value: `undef`

##### `task_epilog_source`

Data type: `Any`



Default value: `undef`

##### `manage_task_prolog`

Data type: `Any`



Default value: `true`

##### `task_prolog`

Data type: `Any`



Default value: `undef`

##### `task_prolog_source`

Data type: `Any`



Default value: `undef`

##### `slurmrestd_listen_address`

Data type: `String`



Default value: '0.0.0.0'

##### `slurmrestd_auth_type`

Data type: `String`



Default value: 'auth/jwt'

##### `slurmrestd_user`

Data type: `String`



Default value: 'nobody'

##### `slurmrestd_user_group`

Data type: `String`



Default value: 'nobody'

##### `slurmrestd_service_ensure`

Data type: `Enum['running','stopped']`



Default value: 'running'

##### `slurmrestd_service_enable`

Data type: `Boolean`



Default value: `true`

##### `slurmrestd_service_limits`

Data type: `Hash`



Default value: {}

##### `slurmrestd_options`

Data type: `String`



Default value: ''

##### `slurmrestd_restart_on_failure`

Data type: `Boolean`



Default value: `true`

##### `cgroup_conf_template`

Data type: `String`



Default value: 'slurm/cgroup/cgroup.conf.erb'

##### `cgroup_conf_source`

Data type: `Optional[String]`



Default value: `undef`

##### `cgroup_automount`

Data type: `Boolean`



Default value: `true`

##### `cgroup_mountpoint`

Data type: `Stdlib::Absolutepath`



Default value: '/sys/fs/cgroup'

##### `cgroup_allowed_kmem_space`

Data type: `Optional[Integer]`



Default value: `undef`

##### `cgroup_allowed_ram_space`

Data type: `Integer`



Default value: 100

##### `cgroup_allowed_swap_space`

Data type: `Integer`



Default value: 0

##### `cgroup_constrain_cores`

Data type: `Boolean`



Default value: `false`

##### `cgroup_constrain_devices`

Data type: `Boolean`



Default value: `false`

##### `cgroup_constrain_kmem_space`

Data type: `Boolean`



Default value: `false`

##### `cgroup_constrain_ram_space`

Data type: `Boolean`



Default value: `false`

##### `cgroup_constrain_swap_space`

Data type: `Boolean`



Default value: `false`

##### `cgroup_max_ram_percent`

Data type: `Integer`



Default value: 100

##### `cgroup_max_swap_percent`

Data type: `Integer`



Default value: 100

##### `cgroup_max_kmem_percent`

Data type: `Integer`



Default value: 100

##### `cgroup_memory_swappiness`

Data type: `Optional[Integer[0,100]]`



Default value: `undef`

##### `cgroup_min_kmem_space`

Data type: `Integer`



Default value: 30

##### `cgroup_min_ram_space`

Data type: `Integer`



Default value: 30

##### `cgroup_task_affinity`

Data type: `Boolean`



Default value: `false`

##### `slurm_sh_template`

Data type: `Any`



Default value: 'slurm/profile.d/slurm.sh.erb'

##### `slurm_csh_template`

Data type: `Any`



Default value: 'slurm/profile.d/slurm.csh.erb'

##### `profile_d_env_vars`

Data type: `Hash`



Default value: {}

##### `slurmd_port`

Data type: `Stdlib::Port`



Default value: 6818

##### `slurmctld_port`

Data type: `Stdlib::Port`



Default value: 6817

##### `slurmdbd_port`

Data type: `Stdlib::Port`



Default value: 6819

##### `slurmrestd_port`

Data type: `Stdlib::Port`



Default value: 6820

##### `tuning_net_core_somaxconn`

Data type: `Variant[Boolean, Integer]`



Default value: 1024

##### `include_resources`

Data type: `Boolean`



Default value: `false`

##### `clusters`

Data type: `Hash`



Default value: {}

##### `qoses`

Data type: `Hash`



Default value: {}

##### `reservations`

Data type: `Hash`



Default value: {}

##### `accounts`

Data type: `Hash`



Default value: {}

##### `users`

Data type: `Hash`



Default value: {}

##### `licenses`

Data type: `Hash`



Default value: {}

##### `purge_qos`

Data type: `Boolean`



Default value: `false`

##### `slurmdbd_conn_validator_timeout`

Data type: `Integer`



Default value: 30

## Defined types

### slurm::down_node

Manage SLURM down node configuration

#### Parameters

The following parameters are available in the `slurm::down_node` defined type.

##### `down_nodes`

Data type: `String`



Default value: $name

##### `reason`

Data type: `Optional[String]`



Default value: `undef`

##### `state`

Data type: `Slurm::DownNodeState`



Default value: 'UNKNOWN'

##### `order`

Data type: `Any`



Default value: '75'

### slurm::gres

Manage SLURM GRES configuration

#### Examples

##### Add static GPU GRES

```puppet
slurm::gres { 'gpu':
  type  => 'v100',
  file  => '/dev/nvidia0',
  cores => '0,1',
}
```

##### Add nvml AutoDetect gres

```puppet
slurm::gres { 'nvml':
  auto_detect => 'nvml',
}
```

#### Parameters

The following parameters are available in the `slurm::gres` defined type.

##### `gres_name`

Data type: `Any`



Default value: $name

##### `type`

Data type: `Any`



Default value: `undef`

##### `node_name`

Data type: `Any`



Default value: `undef`

##### `auto_detect`

Data type: `Optional[Enum['nvml']]`



Default value: `undef`

##### `count`

Data type: `Any`



Default value: `undef`

##### `cores`

Data type: `Any`



Default value: `undef`

##### `file`

Data type: `Any`



Default value: `undef`

##### `flags`

Data type: `Optional[Enum['CountOnly']]`



Default value: `undef`

##### `links`

Data type: `Any`



Default value: `undef`

##### `switch_name`

Data type: `Any`



Default value: $name

##### `switches`

Data type: `Any`



Default value: `undef`

##### `link_speed`

Data type: `Any`



Default value: `undef`

##### `order`

Data type: `Any`



Default value: '50'

### slurm::node

Manage SLURM node configuration

#### Parameters

The following parameters are available in the `slurm::node` defined type.

##### `node_name`

Data type: `Any`



Default value: $name

##### `node_hostname`

Data type: `Any`



Default value: `undef`

##### `node_addr`

Data type: `Any`



Default value: `undef`

##### `boards`

Data type: `Any`



Default value: `undef`

##### `core_spec_count`

Data type: `Any`



Default value: `undef`

##### `cores_per_socket`

Data type: `Any`



Default value: `undef`

##### `cpu_bind`

Data type: `Any`



Default value: `undef`

##### `cpus`

Data type: `Any`



Default value: `undef`

##### `cpu_spec_list`

Data type: `Any`



Default value: `undef`

##### `feature`

Data type: `Any`



Default value: `undef`

##### `gres`

Data type: `Any`



Default value: `undef`

##### `mem_spec_limit`

Data type: `Any`



Default value: `undef`

##### `port`

Data type: `Any`



Default value: `undef`

##### `real_memory`

Data type: `Any`



Default value: `undef`

##### `sockets`

Data type: `Any`



Default value: `undef`

##### `sockets_per_board`

Data type: `Any`



Default value: `undef`

##### `state`

Data type: `Slurm::NodeState`



Default value: 'UNKNOWN'

##### `threads_per_core`

Data type: `Any`



Default value: `undef`

##### `tmp_disk`

Data type: `Optional[Integer]`



Default value: `undef`

##### `tres_weights`

Data type: `Any`



Default value: `undef`

##### `weight`

Data type: `Optional[Integer]`



Default value: `undef`

##### `order`

Data type: `Any`



Default value: '90'

### slurm::nodeset

Manage SLURM nodeset configuration

#### Parameters

The following parameters are available in the `slurm::nodeset` defined type.

##### `feature`

Data type: `Optional[String]`



Default value: `undef`

##### `nodes`

Data type: `Optional[String]`



Default value: `undef`

##### `node_set`

Data type: `String`



Default value: $name

##### `order`

Data type: `Any`



Default value: '40'

### slurm::partition

Manage a SLURM partition configuration

#### Parameters

The following parameters are available in the `slurm::partition` defined type.

##### `partition_name`

Data type: `Any`



Default value: $name

##### `alloc_nodes`

Data type: `Any`



Default value: `undef`

##### `allow_accounts`

Data type: `Any`



Default value: `undef`

##### `allow_groups`

Data type: `Any`



Default value: `undef`

##### `allow_qos`

Data type: `Any`



Default value: `undef`

##### `alternate`

Data type: `Any`



Default value: `undef`

##### `cpu_bind`

Data type: `Any`



Default value: `undef`

##### `default`

Data type: `Optional[Enum['YES','NO']]`



Default value: `undef`

##### `def_cpu_per_gpu`

Data type: `Any`



Default value: `undef`

##### `def_mem_per_cpu`

Data type: `Any`



Default value: `undef`

##### `def_mem_per_gpu`

Data type: `Any`



Default value: `undef`

##### `def_mem_per_node`

Data type: `Any`



Default value: `undef`

##### `deny_accounts`

Data type: `Any`



Default value: `undef`

##### `deny_qos`

Data type: `Any`



Default value: `undef`

##### `default_time`

Data type: `Any`



Default value: `undef`

##### `disable_root_jobs`

Data type: `Optional[Enum['YES','NO']]`



Default value: `undef`

##### `exclusive_user`

Data type: `Optional[Enum['YES','NO']]`



Default value: `undef`

##### `grace_time`

Data type: `Any`



Default value: `undef`

##### `hidden`

Data type: `Optional[Enum['YES','NO']]`



Default value: `undef`

##### `lln`

Data type: `Optional[Enum['YES','NO']]`



Default value: `undef`

##### `max_cpus_per_node`

Data type: `Any`



Default value: `undef`

##### `max_mem_per_cpu`

Data type: `Any`



Default value: `undef`

##### `max_mem_per_node`

Data type: `Any`



Default value: `undef`

##### `max_nodes`

Data type: `Any`



Default value: `undef`

##### `max_time`

Data type: `Any`



Default value: `undef`

##### `min_nodes`

Data type: `Any`



Default value: `undef`

##### `nodes`

Data type: `Any`



Default value: `undef`

##### `over_subscribe`

Data type: `Optional[Enum['EXCLUSIVE','FORCE','YES','NO']]`



Default value: `undef`

##### `preempt_mode`

Data type: `Optional[Slurm::PreemptMode]`



Default value: `undef`

##### `priority_job_factor`

Data type: `Any`



Default value: `undef`

##### `priority_tier`

Data type: `Any`



Default value: `undef`

##### `qos`

Data type: `Any`



Default value: `undef`

##### `req_resv`

Data type: `Any`



Default value: `undef`

##### `root_only`

Data type: `Optional[Enum['YES','NO']]`



Default value: `undef`

##### `select_type_parameters`

Data type: `Optional[Slurm::SelectTypeParameters]`



Default value: `undef`

##### `shared`

Data type: `Any`



Default value: `undef`

##### `state`

Data type: `Slurm::PartitionState`



Default value: 'UP'

##### `tres_billing_weights`

Data type: `Any`



Default value: `undef`

##### `order`

Data type: `Any`



Default value: '50'

### slurm::spank

Manage SLURM SPANK plugin

#### Parameters

The following parameters are available in the `slurm::spank` defined type.

##### `plugin`

Data type: `String`

The shared library

Default value: "${name}.so"

##### `arguments`

Data type: `Optional[Variant[Hash, Array, String]]`

Arguments for the plugin

Default value: `undef`

##### `required`

Data type: `Boolean`

Is this plugin required?

Default value: `false`

##### `manage_package`

Data type: `Boolean`

Manage plugin package?

Default value: `true`

##### `package_name`

Data type: `String`

Plugin package name

Default value: "slurm-spank-${name}"

##### `package_ensure`

Data type: `String`

Plugin package ensure value

Default value: 'installed'

##### `order`

Data type: `Any`

Order in plugstack.conf

Default value: '50'

### slurm::switch

Add switch to topology.conf

#### Examples

##### 

```puppet
slurm::switch { 'switch1':
  switches => 'switch[2-3],
}
slurm::switch { 'switch2':
  nodes => 'c0[1-2]',
}
```

#### Parameters

The following parameters are available in the `slurm::switch` defined type.

##### `switch_name`

Data type: `Any`

= $name,
SwitchName value, see man page for topology.conf

Default value: $name

##### `switches`

Data type: `Any`

= undef,
Switches value, see man page for topology.conf

Default value: `undef`

##### `nodes`

Data type: `Any`

= undef,
Nodes value, see man page for topology.conf

Default value: `undef`

##### `link_speed`

Data type: `Any`

= undef,
LinkSpeed value, see man page for topology.conf

Default value: `undef`

##### `order`

Data type: `Any`

= '50',
Order inside topology.conf

Default value: '50'

## Data types

### Slurm::DownNodeState

The Slurm::DownNodeState data type.

Alias of `Enum['DOWN', 'DRAIN', 'FAIL', 'FAILING', 'UNKNOWN']`

### Slurm::NodeState

The Slurm::NodeState data type.

Alias of `Variant[Enum['CLOUD','FUTURE'], Slurm::DownNodeState]`

### Slurm::PartitionState

The Slurm::PartitionState data type.

Alias of `Enum['UP', 'DOWN', 'DRAIN', 'INACTIVE']`

### Slurm::PreemptMode

The Slurm::PreemptMode data type.

Alias of `Enum['OFF', 'CANCEL', 'CHECKPOINT', 'GANG', 'REQUEUE', 'SUSPEND']`

### Slurm::SelectTypeParameters

The Slurm::SelectTypeParameters data type.

Alias of `Enum['CR_Core', 'CR_Core_Memory', 'CR_Socket', 'CR_Socket_Memory']`

## Tasks

### reconfig

Execute 'scontrol reconfig'

**Supports noop?** false

#### Parameters

##### `scontrol`

Data type: `String[1]`

Path to scontrol (default: 'scontrol', searches $PATH)

