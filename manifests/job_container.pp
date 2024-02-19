# @summary Manage SLURM job_container.conf entry
#
# @param base_path
#   job_container.conf BasePath
# @param auto_base_path
#   job_container.conf AutoBasePath
# @param dirs
#   job_container.conf Dirs
# @param init_script
#   job_container.conf InitScript
# @param node_name
#   job_container.conf NodeName
# @param order
#   Order in job_container.conf
#
define slurm::job_container (
  Stdlib::Absolutepath $base_path,
  Boolean $auto_base_path                     = false,
  Optional[Array[Stdlib::Absolutepath]] $dirs = undef,
  Optional[Stdlib::Absolutepath] $init_script = undef,
  Optional[String] $node_name                 = undef,
  Variant[String[1], Integer] $order = '50',
) {
  include slurm

  $_base_path = "BasePath=${base_path}"
  $_auto_base_path = "AutoBasePath=${auto_base_path}"

  if $dirs {
    $_dirs = "Dirs=${dirs.join(',')}"
  } else {
    $_dirs = undef
  }

  if $init_script {
    $_init_script = "InitScript=${init_script}"
  } else {
    $_init_script = undef
  }

  if $node_name {
    $node_param = "NodeName=${node_name}"
  } else {
    $node_param = undef
  }

  if $node_name {
    $params = [
      $node_param,
      $_auto_base_path,
      $_base_path,
      $_dirs,
      $_init_script,
    ].filter |$p| { $p =~ NotUndef }
    $content = "${strip(join($params, ' '))}\n"
  } else {
    $params = [
      $_base_path,
      $_dirs,
      $_init_script,
    ].filter |$p| { $p =~ NotUndef }
    $content = "${_auto_base_path}\n${params.join(' ')}"
  }

  concat::fragment { "job_container.conf-${name}":
    target  => 'job_container.conf',
    content => $content,
    order   => $order,
  }
}
