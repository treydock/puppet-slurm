# @api private
class slurm::slurmdbd {

  contain slurm::common::munge
  contain slurm::common::user
  contain slurm::common::install
  contain slurm::common::setup
  contain slurm::common::config
  contain slurm::slurmdbd::config
  contain slurm::slurmdbd::service

  Class['::munge::service']
  -> Class['slurm::slurmdbd::service']

  Class['slurm::common::user']
  -> Class['slurm::common::install']
  -> Class['slurm::common::setup']
  -> Class['slurm::common::config']
  -> Class['slurm::slurmdbd::config']
  -> Class['slurm::slurmdbd::service']

  if $slurm::manage_firewall {
    firewall {'100 allow access to slurmdbd':
      proto  => 'tcp',
      dport  => $slurm::slurmdbd_port,
      action => 'accept'
    }
  }

}
