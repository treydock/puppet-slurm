# @api private
class slurm::slurmrestd::config {
  file { 'slurmrestd.conf':
    ensure  => 'file',
    path    => $slurm::slurmrestd_conf_path,
    owner   => $slurm::slurmrestd_user,
    group   => $slurm::slurmrestd_user_group,
    mode    => '0644',
    content => join([
      '# File managed by Puppet, do not edit',
      "include ${slurm::slurm_conf_path}",
      "AuthType=${slurm::slurmrestd_auth_type}",
      '',
    ], "\n"),
    notify  => Service['slurmrestd'],
  }
}
