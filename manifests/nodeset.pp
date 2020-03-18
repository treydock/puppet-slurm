# @summary Manage SLURM nodeset configuration
#
#
#
#
# @param feature
# @param nodes
# @param node_set
# @param order
#
define slurm::nodeset (
  Optional[String] $feature   = undef,
  Optional[String] $nodes     = undef,
  String $node_set            = $name,
  $order                      = '40',
) {

  include ::slurm

  if $nodes {
    $_nodes = "Nodes=${nodes}"
  } else {
    $_nodes = undef
  }

  if $feature {
    $_feature = "Feature=${feature}"
  } else {
    $_feature = undef
  }

  $params = ["NodeSet=${node_set}", $_nodes, $_feature].filter |$v| { $v =~ NotUndef }

  $content = join($params, ' ')

  concat::fragment { "slurm-partitions.conf-nodeset-${name}":
    target  => 'slurm-partitions.conf',
    content => $content,
    order   => $order,
  }

}
