# @summary Manage SLURM resources using Puppet types
# @api private
class slurm::resources {
  include slurm

  slurm_config { 'puppet':
    install_prefix => $slurm::install_prefix,
  }

  slurmdbd_conn_validator { 'puppet':
    ensure  => 'present',
    timeout => $slurm::slurmdbd_conn_validator_timeout,
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
  $slurm::accounts.each |$name, $account| {
    slurm_account { $name: * => $account }
  }
  $slurm::users.each |$name, $user| {
    slurm_user { $name: * => $user }
  }
  $slurm::licenses.each |$name, $license| {
    slurm_license { $name: * => $license }
  }

  if $slurm::purge_qos {
    resources { 'slurm_qos': purge => true }
  }
}
