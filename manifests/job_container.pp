# @summary Manage SLURM job_container.conf entry
#
# @param base_path
#   job_container.conf BasePath
# @param auto_base_path
#   job_container.conf AutoBasePath
# @param dirs
#   job_container.conf Dirs
# @param clone_ns_script
#   job_container.conf CloneNSScript
# @param clone_ns_script_wait
#   job_container.conf CloneNSScript_Wait
# @param clone_ns_epilog
#   job_contaner.conf CloneNSEpilog
# @param clone_ns_epilog_wait
#   job_contaner.conf CloneNSEpilog_Wait
# @param entire_step_in_ns
#   job_container.conf EntireStepInNS
# @param init_script
#   job_container.conf InitScript
# @param node_name
#   job_container.conf NodeName
# @param shared
#   job_container.conf Shared
# @param order
#   Order in job_container.conf
#
define slurm::job_container (
  Stdlib::Absolutepath $base_path,
  Boolean $auto_base_path                     = false,
  Array[Stdlib::Absolutepath] $dirs = [],
  Optional[Stdlib::Absolutepath] $clone_ns_script = undef,
  Optional[Integer] $clone_ns_script_wait = undef,
  Optional[Stdlib::Absolutepath] $clone_ns_epilog = undef,
  Optional[Integer] $clone_ns_epilog_wait = undef,
  Optional[Boolean] $entire_step_in_ns = undef,
  Optional[Stdlib::Absolutepath] $init_script = undef,
  Optional[String] $node_name                 = undef,
  Optional[Boolean] $shared = undef,
  Variant[String[1], Integer] $order = '50',
) {
  include slurm

  if $node_name {
    $start_values = {
      'NodeName' => $node_name,
      'AutoBasePath' => $auto_base_path,
    }
    $first_line = ''
  } else {
    $start_values = {}
    $first_line = "AutoBasePath=${auto_base_path}\n"
  }

  $conf_values = $start_values + {
    'BasePath' => $base_path,
    'Dirs' => $dirs.join(','),
    'CloneNSScript' => $clone_ns_script,
    'CloneNSScript_Wait' => $clone_ns_script_wait,
    'CloneNSEpilog' => $clone_ns_epilog,
    'CloneNSEpilog_Wait' => $clone_ns_epilog_wait,
    'EntireStepInNS' => $entire_step_in_ns,
    'InitScript' => $init_script,
    'Shared' => $shared,
  }.filter |$k, $v| { $v =~ NotUndef and $v != '' }

  $conf = $conf_values.map |$k, $v| {
    "${k}=${v}"
  }.join(' ')

  $content = "${first_line}${strip($conf)}\n"

  concat::fragment { "job_container.conf-${name}":
    target  => 'job_container.conf',
    content => $content,
    order   => $order,
  }
}
