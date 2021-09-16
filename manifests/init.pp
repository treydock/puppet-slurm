# @summary Manage SLURM
#
#
#
#
# Roles
# @param slurmd
# @param slurmctld
# @param slurmdbd
# @param database
# @param client
# @param slurmrestd
# @param repo_baseurl
# @param install_method
# @param install_prefix
# @param package_ensure
# @param install_torque_wrapper
# @param install_pam
# @param version
# @param source_dependencies
# @param configure_flags
# @param source_install_manage_alternatives
# @param slurmd_service_ensure
# @param slurmd_service_enable
# @param slurmd_service_limits
# @param slurmd_options
# @param slurmctld_service_ensure
# @param slurmctld_service_enable
# @param slurmctld_service_limits
# @param slurmctld_options
# @param slurmdbd_service_ensure
# @param slurmdbd_service_enable
# @param slurmdbd_service_limits
# @param slurmdbd_options
# @param slurmctld_restart_on_failure
# @param slurmdbd_restart_on_failure
# @param reload_services
# @param restart_services
# @param manage_slurm_user
# @param slurm_user_group
# @param slurm_group_gid
# @param slurm_user
# @param slurm_user_uid
# @param slurm_user_comment
# @param slurm_user_home
# @param slurm_user_managehome
# @param slurm_user_shell
# @param slurmd_user
# @param slurmd_user_group
# @param manage_slurm_conf
# @param manage_scripts
# @param manage_firewall
# @param use_syslog
# @param manage_logrotate
# @param manage_rsyslog
# @param manage_database
# @param export_database
# @param export_database_tag
# @param cli_filter_lua_source
# @param cli_filter_lua_content
# @param state_dir_nfs_device
# @param state_dir_nfs_options
# @param job_checkpoint_dir_nfs_device
# @param job_checkpoint_dir_nfs_options
# @param job_submit_lua_source
# @param job_submit_lua_content
# @param cluster_name
# @param slurmctld_host
# @param slurmdbd_host
# @param conf_dir
# @param log_dir
# @param env_dir
# @param spank_plugins
# @param configless
# @param conf_server
# @param slurm_conf_override
# @param slurm_conf_template
# @param slurm_conf_source
# @param partition_template
# @param partition_source
# @param node_template
# @param node_source
# @param switch_template
# @param topology_source
# @param gres_template
# @param gres_source
# @param partitions
# @param nodes
# @param nodesets
# @param switches
# @param greses
# @param job_containers
# @param slurmd_log_file
# @param slurmd_spool_dir
# @param job_checkpoint_dir
# @param slurmctld_log_file
# @param state_save_location
# @param slurmdbd_archive_dir
# @param slurmdbd_log_file
# @param slurmdbd_storage_host
# @param slurmdbd_storage_loc
# @param slurmdbd_storage_pass
# @param slurmdbd_storage_port
# @param slurmdbd_storage_type
# @param slurmdbd_storage_user
# @param slurmdbd_conf_override
# @param slurmdbd_archive_dir_nfs_device
# @param slurmdbd_archive_dir_nfs_options
# @param use_nhc
# @param include_nhc
# @param health_check_program
# @param health_check_program_source
# @param manage_epilog
# @param epilog
# @param epilog_source
# @param epilog_sourceselect
# @param manage_prolog
# @param prolog
# @param prolog_source
# @param prolog_sourceselect
# @param manage_task_epilog
# @param task_epilog
# @param task_epilog_source
# @param manage_task_prolog
# @param task_prolog
# @param task_prolog_source
# @param slurmrestd_listen_address
# @param slurmrestd_auth_type
# @param slurmrestd_user
# @param slurmrestd_user_group
# @param slurmrestd_service_ensure
# @param slurmrestd_service_enable
# @param slurmrestd_service_limits
# @param slurmrestd_options
# @param slurmrestd_restart_on_failure
# @param cgroup_conf_template
# @param cgroup_conf_source
# @param cgroup_automount
# @param cgroup_mountpoint
# @param cgroup_allowed_kmem_space
# @param cgroup_allowed_ram_space
# @param cgroup_allowed_swap_space
# @param cgroup_constrain_cores
# @param cgroup_constrain_devices
# @param cgroup_constrain_kmem_space
# @param cgroup_constrain_ram_space
# @param cgroup_constrain_swap_space
# @param cgroup_max_ram_percent
# @param cgroup_max_swap_percent
# @param cgroup_max_kmem_percent
# @param cgroup_memory_swappiness
# @param cgroup_min_kmem_space
# @param cgroup_min_ram_space
# @param cgroup_task_affinity
# @param slurm_sh_template
# @param slurm_csh_template
# @param profile_d_env_vars
# @param slurmd_port
# @param slurmctld_port
# @param slurmdbd_port
# @param slurmrestd_port
# @param tuning_net_core_somaxconn
# @param include_resources
# @param clusters
# @param qoses
# @param reservations
# @param accounts
# @param users
# @param licenses
# @param purge_qos
# @param slurmdbd_conn_validator_timeout
class slurm (
  # Roles
  Boolean $slurmd     = false,
  Boolean $slurmctld  = false,
  Boolean $slurmdbd   = false,
  Boolean $database   = false,
  Boolean $client     = true,
  Boolean $slurmrestd = false,

  # Repo (optional)
  Optional[Variant[Stdlib::HTTPSUrl, Stdlib::HTTPUrl, Pattern[/^file:\/\//]]] $repo_baseurl = undef,


  Optional[Enum['package','source']] $install_method = undef,
  Stdlib::Absolutepath $install_prefix = '/usr',

  # Packages
  String $package_ensure          = 'present',
  Boolean $install_torque_wrapper = false,
  Boolean $install_pam            = true,

  # Source install
  String $version = '20.11.8',
  Array $source_dependencies = [],
  Array $configure_flags = [],
  Boolean $source_install_manage_alternatives = true,

  # Services
  Enum['running','stopped'] $slurmd_service_ensure    = 'running',
  Boolean $slurmd_service_enable                      = true,
  Hash $slurmd_service_limits                         = {},
  String $slurmd_options                              = '',
  Enum['running','stopped'] $slurmctld_service_ensure = 'running',
  Boolean $slurmctld_service_enable                   = true,
  Hash $slurmctld_service_limits                      = {},
  String $slurmctld_options                           = '',
  Enum['running','stopped'] $slurmdbd_service_ensure  = 'running',
  Boolean $slurmdbd_service_enable                    = true,
  Hash $slurmdbd_service_limits                       = {},
  String $slurmdbd_options                            = '',
  Boolean $slurmctld_restart_on_failure               = true,
  Boolean $slurmdbd_restart_on_failure                = true,
  Boolean $reload_services                            = true,
  Boolean $restart_services                           = false,

  # User and group management
  $manage_slurm_user      = true,
  $slurm_user_group       = 'slurm',
  $slurm_group_gid        = undef,
  $slurm_user             = 'slurm',
  $slurm_user_uid         = undef,
  $slurm_user_comment     = 'SLURM User',
  $slurm_user_home        = '/var/lib/slurm',
  $slurm_user_managehome  = true,
  $slurm_user_shell       = '/sbin/nologin',
  $slurmd_user            = 'root',
  $slurmd_user_group      = 'root',

  # Behavior overrides
  $manage_slurm_conf             = true,
  $manage_scripts                = true,
  $manage_firewall               = true,

  # Logging
  $use_syslog                    = false,
  $manage_logrotate              = true,
  $manage_rsyslog                = true,

  # Behavior overrides - slurmdbd
  $manage_database     = true,
  $export_database     = false,
  $export_database_tag = $facts['domain'],

  # client config
  $cli_filter_lua_source  = undef,
  $cli_filter_lua_content = undef,

  # Config - controller
  $state_dir_nfs_device           = undef,
  $state_dir_nfs_options          = 'rw,sync,noexec,nolock,auto',
  $job_checkpoint_dir_nfs_device  = undef,
  $job_checkpoint_dir_nfs_options = 'rw,sync,noexec,nolock,auto',
  $job_submit_lua_source          = undef,
  $job_submit_lua_content         = undef,

  # Cluster config
  $cluster_name       = 'linux',
  Variant[Array, String] $slurmctld_host = 'slurm',
  $slurmdbd_host      = 'slurmdbd',

  # Managed directories
  Stdlib::Absolutepath $conf_dir = '/etc/slurm',
  Stdlib::Absolutepath $log_dir  = '/var/log/slurm',
  Stdlib::Absolutepath $env_dir  = '/etc/sysconfig',

  # configless
  Boolean $configless            = false,
  Optional[String] $conf_server  = undef,

  # slurm.conf - overrides
  $slurm_conf_override    = {},
  $slurm_conf_template    = 'slurm/slurm.conf/slurm.conf.erb',
  $slurm_conf_source      = undef,
  $partition_template     = 'slurm/slurm.conf/conf_values.erb',
  $partition_source       = undef,
  $node_template          = 'slurm/slurm.conf/conf_values.erb',
  $node_source            = undef,
  $switch_template        = 'slurm/slurm.conf/conf_values.erb',
  $topology_source        = undef,
  $gres_template          = 'slurm/slurm.conf/conf_values.erb',
  $gres_source            = undef,
  $partitions             = {},
  $nodes                  = {},
  $nodesets               = {},
  $switches               = {},
  $greses                 = {},
  $job_containers         = {},

  # slurm.conf - node
  Optional[Stdlib::Absolutepath] $slurmd_log_file  = undef,
  $slurmd_spool_dir = '/var/spool/slurmd',

  # slurm.conf - controller
  $job_checkpoint_dir     = '/var/spool/slurmctld.checkpoint',
  Optional[Stdlib::Absolutepath] $slurmctld_log_file     = undef,
  $state_save_location    = '/var/spool/slurmctld.state',

  # slurmdbd.conf
  Stdlib::Absolutepath $slurmdbd_archive_dir = '/var/lib/slurmdbd.archive',
  Optional[Stdlib::Absolutepath] $slurmdbd_log_file      = undef,
  $slurmdbd_storage_host  = 'localhost',
  $slurmdbd_storage_loc   = 'slurm_acct_db',
  $slurmdbd_storage_pass  = 'slurmdbd',
  $slurmdbd_storage_port  = '3306',
  $slurmdbd_storage_type  = 'accounting_storage/mysql',
  $slurmdbd_storage_user  = 'slurmdbd',
  $slurmdbd_conf_override = {},

  # Config - slurmdbd
  $slurmdbd_archive_dir_nfs_device = undef,
  $slurmdbd_archive_dir_nfs_options = 'rw,sync,noexec,nolock,auto',

  # slurm.conf health check
  $use_nhc                      = false,
  $include_nhc                  = false,
  $health_check_program         = undef,
  $health_check_program_source  = undef,

  # slurm.conf - epilog/prolog
  $manage_epilog                = true,
  $epilog                       = undef,
  $epilog_source                = undef,
  $epilog_sourceselect          = undef,
  $manage_prolog                = true,
  $prolog                       = undef,
  $prolog_source                = undef,
  $prolog_sourceselect          = undef,
  $manage_task_epilog           = true,
  $task_epilog                  = undef,
  $task_epilog_source           = undef,
  $manage_task_prolog           = true,
  $task_prolog                  = undef,
  $task_prolog_source           = undef,

  # slurmrestd
  String $slurmrestd_listen_address = '0.0.0.0',
  String $slurmrestd_auth_type = 'auth/jwt',
  String $slurmrestd_user = 'nobody',
  String $slurmrestd_user_group = 'nobody',
  Enum['running','stopped'] $slurmrestd_service_ensure = 'running',
  Boolean $slurmrestd_service_enable                   = true,
  Hash $slurmrestd_service_limits                      = {},
  String $slurmrestd_options                           = '',
  Boolean $slurmrestd_restart_on_failure               = true,

  # cgroups
  String $cgroup_conf_template             = 'slurm/cgroup/cgroup.conf.erb',
  Optional[String] $cgroup_conf_source               = undef,
  Boolean $cgroup_automount                 = true,
  Stdlib::Absolutepath $cgroup_mountpoint                = '/sys/fs/cgroup',
  Optional[Integer] $cgroup_allowed_kmem_space = undef,
  Integer $cgroup_allowed_ram_space         = 100,
  Integer $cgroup_allowed_swap_space        = 0,
  Boolean $cgroup_constrain_cores           = false,
  Boolean $cgroup_constrain_devices         = false,
  Boolean $cgroup_constrain_kmem_space       = false,
  Boolean $cgroup_constrain_ram_space       = false,
  Boolean $cgroup_constrain_swap_space      = false,
  Integer $cgroup_max_ram_percent           = 100,
  Integer $cgroup_max_swap_percent          = 100,
  Integer $cgroup_max_kmem_percent          = 100,
  Optional[Integer[0,100]] $cgroup_memory_swappiness = undef,
  Integer $cgroup_min_kmem_space             = 30,
  Integer $cgroup_min_ram_space             = 30,
  Boolean $cgroup_task_affinity             = false,

  # profile.d
  $slurm_sh_template  = 'slurm/profile.d/slurm.sh.erb',
  $slurm_csh_template = 'slurm/profile.d/slurm.csh.erb',
  Hash $profile_d_env_vars = {},

  # ports
  Stdlib::Port $slurmd_port    = 6818,
  Stdlib::Port $slurmctld_port = 6817,
  Stdlib::Port $slurmdbd_port  = 6819,
  Stdlib::Port $slurmrestd_port = 6820,

  # tuning
  Variant[Boolean, Integer] $tuning_net_core_somaxconn = 1024,

  # resource management
  Boolean $include_resources = false,
  Hash $spank_plugins = {},
  Hash $clusters = {},
  Hash $qoses = {},
  Hash $reservations = {},
  Hash $accounts = {},
  Hash $users = {},
  Hash $licenses = {},
  Boolean $purge_qos = false,
  Integer $slurmdbd_conn_validator_timeout = 30,
) inherits slurm::params {

  $osfamily = $facts.dig('os', 'family')
  $osmajor = $facts.dig('os', 'release', 'major')
  $os = "${osfamily}-${osmajor}"
  $supported = ['RedHat-7','RedHat-8','Debian-10']
  if ! ($os in $supported) {
    fail("Unsupported OS: ${os}, module ${module_name} only supports RedHat 7 and 8, Debian 10")
  }

  if ! ($slurmd or $slurmctld or $slurmdbd or $database or $client or $slurmrestd) {
    fail("Module ${module_name}: Must select a mode of either slurmd, slurmctld, slurmrestd, slurmdbd database, or client.")
  }

  $slurm_conf_path                    = "${conf_dir}/slurm.conf"
  $topology_conf_path                 = "${conf_dir}/topology.conf"
  $gres_conf_path                     = "${conf_dir}/gres.conf"
  $slurmdbd_conf_path                 = "${conf_dir}/slurmdbd.conf"
  $cgroup_conf_path                   = "${conf_dir}/cgroup.conf"
  $plugstack_conf_path                = "${conf_dir}/plugstack.conf"
  $slurmrestd_conf_path               = "${conf_dir}/slurmrestd.conf"
  $job_container_conf_path            = "${conf_dir}/job_container.conf"

  if $install_prefix in ['/usr','/usr/local'] {
    $profiled_add_path = false
  } else {
    $profiled_add_path = true
  }

  if $use_syslog {
    $_slurmctld_log_file = 'UNSET'
    $_slurmdbd_log_file = 'UNSET'
    $_slurmd_log_file = 'UNSET'
    $_logrotate_postrotate = '/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true'
  } else {
    $_slurmctld_log_file = pick($slurmctld_log_file, "${log_dir}/slurmctld.log")
    $_slurmdbd_log_file = pick($slurmdbd_log_file, "${log_dir}/slurmdbd.log")
    $_slurmd_log_file = pick($slurmd_log_file, "${log_dir}/slurmd.log")
    $_logrotate_postrotate = [
      'pkill -x --signal SIGUSR2 slurmctld',
      'pkill -x --signal SIGUSR2 slurmd',
      'pkill -x --signal SIGUSR2 slurmdbd',
      'exit 0',
    ]
  }

  if $use_nhc {
    $_health_check_program = pick($health_check_program, '/usr/sbin/nhc')
  } else {
    $_health_check_program = $health_check_program
  }

  $slurm_conf_local_defaults = {
    'AccountingStorageHost' => $slurmdbd_host,
    'AccountingStoragePort' => $slurmdbd_port,
    'ClusterName' => $cluster_name,
    'DefaultStorageHost' => $slurmdbd_host,
    'DefaultStoragePort' => $slurmdbd_port,
    'Epilog' => $epilog,
    'EpilogSlurmctld' => undef, #TODO
    'HealthCheckProgram' => $_health_check_program,
    'JobCheckpointDir' => $job_checkpoint_dir,
    # Must remained undefined to support configless, we save to same directory as slurm.conf
    'PlugStackConfig' => undef,
    'Prolog' => $prolog,
    'PrologSlurmctld' => undef, #TODO
    'ResvEpilog' => undef, #TODO
    'ResvProlog' => undef, #TODO
    'SlurmUser' => $slurm_user,
    'SlurmctldHost' => $slurmctld_host,
    'SlurmctldLogFile' => $_slurmctld_log_file,
    'SlurmctldPort' => $slurmctld_port,
    'SlurmdLogFile' => $_slurmd_log_file,
    'SlurmdPort' => $slurmd_port,
    'SlurmdSpoolDir' => $slurmd_spool_dir,
    'SlurmSchedLogFile' => "${log_dir}/slurmsched.log",
    'SlurmdUser' => $slurmd_user,
    'SrunEpilog' => undef, #TODO
    'SrunProlog' => undef, #TODO
    'StateSaveLocation' => $state_save_location,
    'TaskEpilog' => $task_epilog,
    'TaskProlog' => $task_prolog,
  }

  $slurm_conf_defaults  = merge($::slurm::params::slurm_conf_defaults, $slurm_conf_local_defaults)
  $slurm_conf           = merge($slurm_conf_defaults, $slurm_conf_override)

  $slurmdbd_conf_local_defaults = {
    'ArchiveDir' => $slurmdbd_archive_dir,
    'DbdHost' => $slurmdbd_host,
    'DbdPort' => $slurmdbd_port,
    'LogFile' => $_slurmdbd_log_file,
    'SlurmUser' => $slurm_user,
    'StorageHost' => $slurmdbd_storage_host,
    'StorageLoc' => $slurmdbd_storage_loc,
    'StoragePass' => $slurmdbd_storage_pass,
    'StoragePort' => $slurmdbd_storage_port,
    'StorageType' => $slurmdbd_storage_type,
    'StorageUser' => $slurmdbd_storage_user,
  }

  $slurmdbd_conf_defaults = merge($::slurm::params::slurmdbd_conf_defaults, $slurmdbd_conf_local_defaults)
  $slurmdbd_conf          = merge($slurmdbd_conf_defaults, $slurmdbd_conf_override)

  if $slurm_conf_source {
    $slurm_conf_content = undef
  } else {
    $slurm_conf_content = template($slurm_conf_template)
  }

  if $cgroup_conf_source {
    $cgroup_conf_content = undef
  } else {
    $cgroup_conf_content = template($cgroup_conf_template)
  }

  if $slurmd and $slurmd_service_ensure == 'running' and $reload_services and $facts['slurmd_version'] {
    $slurmd_notify = Exec['slurmd reload']
  } elsif $slurmd and $slurmd_service_ensure == 'running' and $restart_services {
    $slurmd_notify = Service['slurmd']
  } else {
    $slurmd_notify = undef
  }
  if $slurmctld and $slurmctld_service_ensure == 'running' and $reload_services and $facts['slurmctld_version'] {
    $slurmctld_notify = Exec['scontrol reconfig']
  } elsif $slurmctld and $slurmctld_service_ensure == 'running' and $restart_services {
    $slurmctld_notify = Service['slurmctld']
  } else {
    $slurmctld_notify = undef
  }
  if $slurmdbd and $slurmdbd_service_ensure == 'running' and $reload_services and $facts['slurmdbd_version'] {
    $slurmdbd_notify = Exec['slurmdbd reload']
  } elsif $slurmdbd and $slurmdbd_service_ensure == 'running' and $restart_services {
    $slurmdbd_notify = Service['slurmdbd']
  } else {
    $slurmdbd_notify = undef
  }
  $service_notify = delete_undef_values(flatten([$slurmd_notify, $slurmctld_notify, $slurmdbd_notify]))

  if $state_dir_nfs_device {
    $state_dir_systemd = "RequiresMountsFor=${slurm::state_save_location}"
  } else {
    $state_dir_systemd = undef
  }

  if $job_checkpoint_dir_nfs_device {
    $checkpoint_dir_systemd = "RequiresMountsFor=${slurm::job_checkpoint_dir}"
  } else {
    $checkpoint_dir_systemd = undef
  }

  if $slurmdbd_archive_dir_nfs_device {
    $slurmdbd_archive_dir_systemd = "RequiresMountsFor=${slurm::slurmdbd_archive_dir}"
  } else {
    $slurmdbd_archive_dir_systemd = undef
  }

  if $database {
    contain slurm::slurmdbd::db
  }

  if $slurmdbd {
    contain slurm::slurmdbd
  }

  if $slurmctld {
    contain slurm::slurmctld
  }

  if $slurmd {
    contain slurm::slurmd
  }

  if $client {
    contain slurm::client
  }

  if $slurmrestd {
    contain slurm::slurmrestd
  }

  if $include_resources {
    contain slurm::resources
  }
}
