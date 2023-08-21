# @api private
class slurm::slurmrestd {
  contain slurm::common::user
  contain slurm::common::install
  contain slurm::common::config
  contain slurm::slurmrestd::service

  Class['slurm::common::user']
  -> Class['slurm::common::install']
  -> Class['slurm::common::config']
  -> Class['slurm::slurmrestd::service']

  if $slurm::manage_firewall {
    firewall { '100 allow access to slurmrestd':
      proto  => 'tcp',
      dport  => $slurm::slurmrestd_port,
      action => 'accept',
    }
  }
}
