# @api private
class slurm::common::install::apt {

  Package {
    ensure  => $slurm::package_ensure,
    notify  => $slurm::service_notify,
  }

  if $slurm::slurmd or $slurm::slurmctld or $slurm::client {
    package { 'libslurm-dev': }
    package { 'libslurm-perl': }
    package { 'libpmi0': }
    package { 'libpmi2-0': }
    package { 'slurm-client': }
  }

  if $slurm::slurmd {
    package { 'slurmd': }
  }

  if $slurm::slurmctld {
    package { 'slurmctld': }
  }

  if $slurm::slurmdbd {
    package { 'slurmdbd': }
  }

  if $slurm::slurmrestd {
    package { 'slurm-slurmrestd': }
  }

  if $slurm::install_pam            { package { 'libpam-slurm': } }
  if $slurm::install_torque_wrapper { package { 'slurm-wlm-torque': } }
}
