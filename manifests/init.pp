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
# @param slurmctld_conn_validator_timeout
# @param reconfig_ignore_errors
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
# @param manage_munge
# @param munge_key_source
# @param munge_key_content
# @param manage_slurm_conf
# @param manage_scripts
# @param manage_firewall
# @param use_syslog
# @param manage_logrotate
# @param logrotate_syslog_pid_path
# @param manage_rsyslog
# @param manage_database
# @param export_database
# @param export_database_tag
# @param cli_filter_lua_source
# @param cli_filter_lua_content
# @param scrun_lua_source
# @param scrun_lua_content
# @param state_dir_nfs_device
# @param state_dir_nfs_options
# @param job_submit_lua_source
# @param job_submit_lua_content
# @param cluster_name
# @param slurmctld_host
# @param slurmdbd_host
# @param conf_dir
# @param log_dir
# @param env_dir
# @param spank_plugins
# @param enable_configless
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
# @param slurmdbd_db_charset
# @param slurmdbd_db_collate
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
# @param auth_alt_types
# @param jwt_key_content
# @param jwt_key_source
# @param slurmrestd_listen_address
# @param slurmrestd_disable_token_creation
# @param slurmrestd_user
# @param slurmrestd_user_group
# @param slurmrestd_service_ensure
# @param slurmrestd_service_enable
# @param slurmrestd_service_limits
# @param slurmrestd_options
# @param slurmrestd_restart_on_failure
# @param cgroup_conf_template
# @param cgroup_conf_source
# @param cgroup_mountpoint
# @param cgroup_plugin
# @param cgroup_allowed_ram_space
# @param cgroup_allowed_swap_space
# @param cgroup_constrain_cores
# @param cgroup_constrain_devices
# @param cgroup_constrain_ram_space
# @param cgroup_constrain_swap_space
# @param cgroup_max_ram_percent
# @param cgroup_max_swap_percent
# @param cgroup_memory_swappiness
# @param cgroup_min_ram_space
# @param cgroup_signal_child_processes
# @param oci_conf_template
# @param oci_conf_source
# @param oci_container_path
# @param oci_create_env_file
# @param oci_debug_flags
# @param oci_disable_cleanup
# @param oci_disable_hooks
# @param oci_env_exclude
# @param oci_mount_spool_dir
# @param oci_run_time_env_exclude
# @param oci_file_debug
# @param oci_ignore_file_config_json
# @param oci_run_time_create
# @param oci_run_time_delete
# @param oci_run_time_kill
# @param oci_run_time_query
# @param oci_run_time_run
# @param oci_run_time_start
# @param oci_srun_path
# @param oci_srun_args
# @param oci_std_io_debug
# @param oci_syslog_debug
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
  Optional[Enum['package','source','none']] $install_method = undef,
  Stdlib::Absolutepath $install_prefix = '/usr',

  # Packages
  String $package_ensure          = 'present',
  Boolean $install_torque_wrapper = false,
  Boolean $install_pam            = true,

  # Source install
  String $version = '25.11.2',
  Array $source_dependencies = [],
  Array $configure_flags = [],
  Boolean $source_install_manage_alternatives = true,

  # Services
  Enum['running','stopped'] $slurmd_service_ensure    = 'running',
  Boolean $slurmd_service_enable                      = true,
  Hash $slurmd_service_limits                         = {},
  Optional[String[1]] $slurmd_options = undef,
  Enum['running','stopped'] $slurmctld_service_ensure = 'running',
  Boolean $slurmctld_service_enable                   = true,
  Hash $slurmctld_service_limits                      = {},
  Optional[String[1]] $slurmctld_options = undef,
  Enum['running','stopped'] $slurmdbd_service_ensure  = 'running',
  Boolean $slurmdbd_service_enable                    = true,
  Hash $slurmdbd_service_limits                       = {},
  Optional[String[1]] $slurmdbd_options = undef,
  Boolean $slurmctld_restart_on_failure               = true,
  Boolean $slurmdbd_restart_on_failure                = true,
  Boolean $reload_services                            = false,
  Boolean $restart_services                           = true,
  Integer $slurmctld_conn_validator_timeout           = 60,
  Boolean $reconfig_ignore_errors = false,

  # User and group management
  Boolean $manage_slurm_user = true,
  String[1] $slurm_user_group = 'slurm',
  Optional[Integer] $slurm_group_gid = undef,
  String[1] $slurm_user = 'slurm',
  Optional[Integer] $slurm_user_uid = undef,
  String[1] $slurm_user_comment = 'SLURM User',
  Stdlib::Absolutepath $slurm_user_home = '/var/lib/slurm',
  Boolean $slurm_user_managehome = true,
  Stdlib::Absolutepath $slurm_user_shell = '/sbin/nologin',
  String[1] $slurmd_user = 'root',
  String[1] $slurmd_user_group = 'root',

  # Munge key
  Boolean $manage_munge                 = false,
  Optional[String] $munge_key_source    = undef,
  Optional[Variant[String,Binary]] $munge_key_content   = undef,

  # Behavior overrides
  Boolean $manage_slurm_conf             = true,
  Boolean $manage_scripts                = true,
  Boolean $manage_firewall               = true,

  # Logging
  Boolean $use_syslog                    = false,
  Boolean $manage_logrotate              = true,
  Stdlib::Absolutepath $logrotate_syslog_pid_path = '/var/run/syslogd.pid',
  Boolean $manage_rsyslog                = true,

  # Behavior overrides - slurmdbd
  Boolean $manage_database     = true,
  Boolean $export_database     = false,
  Optional[String[1]] $export_database_tag = $facts['networking']['domain'],

  # client config
  Optional[String[1]] $cli_filter_lua_source  = undef,
  Optional[String[1]] $cli_filter_lua_content = undef,
  Optional[String[1]] $scrun_lua_source  = undef,
  Optional[String[1]] $scrun_lua_content = undef,

  # Config - controller
  Optional[String[1]] $state_dir_nfs_device           = undef,
  String[1] $state_dir_nfs_options = 'rw,sync,noexec,nolock,auto',
  Optional[String[1]] $job_submit_lua_source          = undef,
  Optional[String[1]] $job_submit_lua_content         = undef,

  # Cluster config
  String[1] $cluster_name       = 'linux',
  Variant[Array, String] $slurmctld_host = 'slurm',
  Stdlib::Host $slurmdbd_host      = 'slurmdbd',

  # Managed directories
  Stdlib::Absolutepath $conf_dir = '/etc/slurm',
  Stdlib::Absolutepath $log_dir  = '/var/log/slurm',
  Stdlib::Absolutepath $env_dir  = '/etc/sysconfig',

  # configless
  Boolean $enable_configless     = false,
  Boolean $configless            = false,
  Optional[String] $conf_server  = undef,

  # slurm.conf - overrides
  Hash $slurm_conf_override = {},
  String[1] $slurm_conf_template = 'slurm/slurm.conf/slurm.conf.erb',
  Optional[String[1]] $slurm_conf_source = undef,
  String[1] $partition_template = 'slurm/slurm.conf/conf_values.erb',
  Optional[String[1]] $partition_source = undef,
  String[1] $node_template = 'slurm/slurm.conf/conf_values.erb',
  Optional[String[1]] $node_source = undef,
  String[1] $switch_template = 'slurm/slurm.conf/conf_values.erb',
  Optional[String[1]] $topology_source = undef,
  String[1] $gres_template = 'slurm/slurm.conf/conf_values.erb',
  Optional[String[1]] $gres_source = undef,
  Hash $partitions             = {},
  Hash $nodes                  = {},
  Hash $nodesets               = {},
  Hash $switches               = {},
  Hash $greses                 = {},
  Hash $job_containers         = {},

  # slurm.conf - node
  Optional[Stdlib::Absolutepath] $slurmd_log_file = undef,
  Stdlib::Absolutepath $slurmd_spool_dir = '/var/spool/slurmd',

  # slurm.conf - controller
  Optional[Stdlib::Absolutepath] $slurmctld_log_file = undef,
  Stdlib::Absolutepath $state_save_location = '/var/spool/slurmctld.state',

  # slurmdbd.conf
  Stdlib::Absolutepath $slurmdbd_archive_dir = '/var/lib/slurmdbd.archive',
  Optional[Stdlib::Absolutepath] $slurmdbd_log_file      = undef,
  Stdlib::Host $slurmdbd_storage_host  = 'localhost',
  String[1] $slurmdbd_storage_loc   = 'slurm_acct_db',
  String[1] $slurmdbd_storage_pass  = 'slurmdbd',
  Variant[Stdlib::Port, String[0,0]] $slurmdbd_storage_port  = 3306,
  String[1] $slurmdbd_storage_type  = 'accounting_storage/mysql',
  String[1] $slurmdbd_storage_user  = 'slurmdbd',
  String[1] $slurmdbd_db_charset = 'utf8',
  String[1] $slurmdbd_db_collate = 'utf8_general_ci',
  Hash $slurmdbd_conf_override = {},

  # Config - slurmdbd
  Optional[String[1]] $slurmdbd_archive_dir_nfs_device = undef,
  String[1] $slurmdbd_archive_dir_nfs_options = 'rw,sync,noexec,nolock,auto',

  # slurm.conf health check
  Boolean $use_nhc = false,
  Boolean $include_nhc = false,
  Optional[Stdlib::Absolutepath] $health_check_program = undef,
  Optional[String[1]] $health_check_program_source = undef,

  # slurm.conf - epilog/prolog
  Boolean $manage_epilog = true,
  Optional[String[1]] $epilog = undef,
  Optional[Variant[String[1], Array[String[1]]]] $epilog_source = undef,
  Optional[String[1]] $epilog_sourceselect = undef,
  Boolean $manage_prolog = true,
  Optional[String[1]] $prolog = undef,
  Optional[Variant[String[1], Array[String[1]]]] $prolog_source = undef,
  Optional[String[1]] $prolog_sourceselect = undef,
  Boolean $manage_task_epilog = true,
  Optional[String[1]] $task_epilog = undef,
  Optional[Variant[String[1], Array[String[1]]]] $task_epilog_source = undef,
  Boolean $manage_task_prolog = true,
  Optional[String[1]] $task_prolog = undef,
  Optional[Variant[String[1], Array[String[1]]]] $task_prolog_source = undef,

  # slurmrestd
  Array $auth_alt_types = [],
  Optional[String] $jwt_key_content = undef,
  Optional[String] $jwt_key_source = undef,
  String $slurmrestd_listen_address = $facts['networking']['ip'],
  Boolean $slurmrestd_disable_token_creation = false,
  String $slurmrestd_user = 'daemon',
  String $slurmrestd_user_group = 'daemon',
  Enum['running','stopped'] $slurmrestd_service_ensure = 'running',
  Boolean $slurmrestd_service_enable                   = true,
  Hash $slurmrestd_service_limits                      = {},
  Optional[String[1]] $slurmrestd_options = undef,
  Boolean $slurmrestd_restart_on_failure               = true,

  # cgroups
  String $cgroup_conf_template             = 'slurm/cgroup/cgroup.conf.erb',
  Optional[String] $cgroup_conf_source               = undef,
  Stdlib::Absolutepath $cgroup_mountpoint                = '/sys/fs/cgroup',
  String $cgroup_plugin = 'autodetect',
  Integer $cgroup_allowed_ram_space         = 100,
  Integer $cgroup_allowed_swap_space        = 0,
  Boolean $cgroup_constrain_cores           = false,
  Boolean $cgroup_constrain_devices         = false,
  Boolean $cgroup_constrain_ram_space       = false,
  Boolean $cgroup_constrain_swap_space      = false,
  Integer $cgroup_max_ram_percent           = 100,
  Integer $cgroup_max_swap_percent          = 100,
  Optional[Integer[0,100]] $cgroup_memory_swappiness = undef,
  Integer $cgroup_min_ram_space             = 30,
  Optional[Boolean] $cgroup_signal_child_processes = undef,

  # OCI
  String $oci_conf_template             = 'slurm/oci.conf.erb',
  Optional[String] $oci_conf_source               = undef,
  Optional[String[1]] $oci_container_path = undef,
  String[1] $oci_create_env_file = 'disabled',
  Optional[String[1]] $oci_debug_flags = undef,
  Boolean $oci_disable_cleanup = false,
  Optional[String[1]] $oci_disable_hooks = undef,
  Optional[String[1]] $oci_env_exclude = undef,
  Stdlib::Absolutepath $oci_mount_spool_dir = '/var/run/slurm/',
  Optional[String[1]] $oci_run_time_env_exclude = undef,
  Optional[String[1]] $oci_file_debug = undef,
  Boolean $oci_ignore_file_config_json = false,
  Optional[String[1]] $oci_run_time_create = undef,
  Optional[String[1]] $oci_run_time_delete = undef,
  Optional[String[1]] $oci_run_time_kill = undef,
  Optional[String[1]] $oci_run_time_query = undef,
  Optional[String[1]] $oci_run_time_run = undef,
  Optional[String[1]] $oci_run_time_start = undef,
  Optional[Stdlib::Absolutepath] $oci_srun_path = undef,
  Optional[String[1]] $oci_srun_args = undef,
  Optional[String[1]] $oci_std_io_debug = undef,
  Optional[String[1]] $oci_syslog_debug = undef,

  # profile.d
  String[1] $slurm_sh_template  = 'slurm/profile.d/slurm.sh.erb',
  String[1] $slurm_csh_template = 'slurm/profile.d/slurm.csh.erb',
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
  $supported = ['RedHat','Debian']
  if ! ($osfamily in $supported) {
    fail("Unsupported OS family: ${osfamily}, module ${module_name} only supports RedHat and Debian")
  }

  if ! ($slurmd or $slurmctld or $slurmdbd or $database or $client or $slurmrestd) {
    fail("Module ${module_name}: Must select a mode of either slurmd, slurmctld, slurmrestd, slurmdbd database, or client.")
  }

  if ('auth/jwt' in $auth_alt_types) and !($jwt_key_content or $jwt_key_source) {
    fail("Module ${module_name}: Must specify either jwt_key_content or jwt_key_source when auth_alt_types includes auth/jwt")
  }

  $slurm_conf_path                    = "${conf_dir}/slurm.conf"
  $topology_conf_path                 = "${conf_dir}/topology.conf"
  $gres_conf_path                     = "${conf_dir}/gres.conf"
  $slurmdbd_conf_path                 = "${conf_dir}/slurmdbd.conf"
  $cgroup_conf_path                   = "${conf_dir}/cgroup.conf"
  $oci_conf_path                      = "${conf_dir}/oci.conf"
  $plugstack_conf_path                = "${conf_dir}/plugstack.conf"
  $job_container_conf_path            = "${conf_dir}/job_container.conf"
  $jwt_key_path                       = "${conf_dir}/jwt.key"
  $src_file                           = "/usr/local/src/slurm-${slurm::version}.tar.bz2"
  $src_dir                            = "/usr/local/src/slurm-${slurm::version}"

  if $install_prefix in ['/usr','/usr/local'] {
    $profiled_add_path = false
  } else {
    $profiled_add_path = true
  }

  if $use_syslog {
    $_slurmctld_log_file = 'UNSET'
    $_slurmdbd_log_file = 'UNSET'
    $_slurmd_log_file = 'UNSET'
    if $slurmctld and String($slurm_conf_override['SlurmSchedLogLevel']) == '1' {
      $_logrotate_slurmctld = 'pkill -x --signal SIGUSR2 slurmctld'
    } else {
      $_logrotate_slurmctld = undef
    }
    $_logrotate_postrotate = [
      "/bin/kill -HUP `cat ${logrotate_syslog_pid_path} 2> /dev/null` 2> /dev/null || true",
      $_logrotate_slurmctld,
      'exit 0',
    ].filter |$v| { $v =~ NotUndef }
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

  if 'auth/jwt' in $auth_alt_types {
    if $slurmrestd_disable_token_creation {
      $_slurmrestd_disable_token_creation = 'disable_token_creation,'
    } else {
      $_slurmrestd_disable_token_creation = ''
    }
    $auth_alt_parameters = "${_slurmrestd_disable_token_creation}jwt_key=${jwt_key_path}"
    $auth_alt_parameters_dbd = "jwt_key=${jwt_key_path}"
  } else {
    $auth_alt_parameters = undef
    $auth_alt_parameters_dbd = undef
  }

  if $enable_configless {
    if 'SlurmctldParameters' in $slurm_conf_override and !('enable_configless' in $slurm_conf_override['SlurmctldParameters']) {
      if $slurm_conf_override['SlurmctldParameters'] =~ Array {
        $slurmctld_parameters = $slurm_conf_override['SlurmctldParameters'] + ['enable_configless']
      } else {
        $slurmctld_parameters = "${slurm_conf_override['SlurmctldParameters']},enable_configless"
      }
    } elsif 'SlurmctldParameters' in $slurm_conf_override {
      $slurmctld_parameters = $slurm_conf_override['SlurmctldParameters']
    } else {
      $slurmctld_parameters = 'enable_configless'
    }
  } else {
    $slurmctld_parameters = $slurm_conf_override['SlurmctldParameters']
  }

  $slurm_conf_local_defaults = {
    'AccountingStorageHost' => $slurmdbd_host,
    'AccountingStoragePort' => $slurmdbd_port,
    'AuthAltTypes' => $auth_alt_types,
    'AuthAltParameters' => $auth_alt_parameters,
    'ClusterName' => $cluster_name,
    'Epilog' => $epilog,
    'EpilogSlurmctld' => undef, #TODO
    'HealthCheckProgram' => $_health_check_program,
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
    'SlurmctldParameters' => $slurmctld_parameters,
    'SlurmdUser' => $slurmd_user,
    'SrunEpilog' => undef, #TODO
    'SrunProlog' => undef, #TODO
    'StateSaveLocation' => $state_save_location,
    'TaskEpilog' => $task_epilog,
    'TaskProlog' => $task_prolog,
  }

  $_slurm_conf_override = $slurm_conf_override - ['SlurmctldParameters']
  $slurm_conf_defaults  = $slurm::params::slurm_conf_defaults + $slurm_conf_local_defaults
  $slurm_conf           = $slurm_conf_defaults + $_slurm_conf_override

  $slurmdbd_conf_local_defaults = {
    'ArchiveDir' => $slurmdbd_archive_dir,
    'AuthAltTypes' => $auth_alt_types,
    'AuthAltParameters' => $auth_alt_parameters_dbd,
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

  $slurmdbd_conf_defaults = $slurm::params::slurmdbd_conf_defaults + $slurmdbd_conf_local_defaults
  $slurmdbd_conf          = $slurmdbd_conf_defaults + $slurmdbd_conf_override

  if $cgroup_conf_source {
    $cgroup_conf_content = undef
  } else {
    $cgroup_conf_content = template($cgroup_conf_template)
  }

  if $oci_conf_source {
    $oci_conf_content = undef
  } else {
    $oci_conf_content = template($oci_conf_template)
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

  if $slurmdbd_archive_dir_nfs_device {
    $slurmdbd_archive_dir_systemd = "RequiresMountsFor=${slurm::slurmdbd_archive_dir}"
  } else {
    $slurmdbd_archive_dir_systemd = undef
  }

  if $use_syslog {
    $logging_systemd_override = 'present'
  } else {
    $logging_systemd_override = 'absent'
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
