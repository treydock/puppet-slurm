# @summary Manage SLURM namespace.yaml node_conf entry
#
# @param nodes
#   namespace.yaml node_conf nodes
# @param options
#   namespace.yaml node_conf options
#
define slurm::namespace::node_conf (
  Array[String[1]] $nodes,
  Slurm::Namespace::Options $options,
) {
  include slurm

  collections::append { "namespace-node-conf-${name}":
    target => 'namespace',
    data   => {
      'node_confs' => [
        {
          'nodes'   => $nodes,
          'options' => $options,
        },
      ],
    },
  }
}
