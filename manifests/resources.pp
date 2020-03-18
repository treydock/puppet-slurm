# @summary Manage SLURM resources using Puppet types
# @api private
class slurm::resources {
  include slurm

  slurm_config { 'puppet':
    install_prefix => $slurm::install_prefix,
  }

  $slurm::clusters.each |$name, $cluster| {
    slurm_cluster { $name: * => $cluster }
  }
  $slurm::qoses.each |$name, $qos| {
    slurm_qos { $name: * => $qos }
  }
  $slurm::reservations.each |$name, $reservation| {
    slurm_reservation { $name: * => $reservation }
  }

  if $slurm::purge_qos {
    resources { 'slurm_qos': purge => true }
  }
}
