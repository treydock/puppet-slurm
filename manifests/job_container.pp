# @summary Manage SLURM job_container.conf entry
#
# @param base_path
#   job_container.conf BasePath
# @param auto_base_path
#   job_container.conf AutoBasePath
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
  Optional[Stdlib::Absolutepath] $init_script = undef,
  Optional[String] $node_name                 = undef,
  $order                                      = '50',
) {

  include slurm

  $_base_path = "BasePath=${base_path}"
  $_auto_base_path = "AutoBasePath=${auto_base_path}"

  if $init_script {
    $_init_script = "InitScript=${init_script}"
  } else {
    $_init_script = undef
  }

  if $node_name {
    $params = delete_undef_values([
      "NodeName=${node_name}",
      $_auto_base_path,
      $_base_path,
      $_init_script,
    ])
    $content = "${strip(join($params, ' '))}\n"
  } else {
    $content = join(delete_undef_values([
      $_auto_base_path,
      $_base_path,
      $_init_script,
    ]), "\n")
  }

  concat::fragment { "job_container.conf-${name}":
    target  => 'job_container.conf',
    content => $content,
    order   => $order,
  }

}
