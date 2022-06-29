# @api private
class slurm::slurmrestd::service {

  file { "${slurm::env_dir}/slurmrestd":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('slurm/sysconfig/slurmrestd.erb'),
    notify  => Service['slurmrestd'],
  }

  if ! empty($slurm::slurmrestd_service_limits) {
    systemd::service_limits { 'slurmrestd.service':
      limits          => $slurm::slurmrestd_service_limits,
      restart_service => false,
      notify          => Service['slurmrestd'],
    }
  }

  systemd::dropin_file { 'slurmrestd-logging.conf':
    ensure         => $slurm::logging_systemd_override,
    unit           => 'slurmrestd.service',
    content        => join([
      '# File managed by Puppet',
      '[Service]',
      'StandardOutput=null',
      'StandardError=null',
    ], "\n"),
    notify_service => false,
    notify         => Service['slurmrestd'],
  }

  systemd::unit_file { 'slurmrestd.service':
    ensure  => 'present',
    content => template('slurm/slurmrestd/slurmrestd.service.erb'),
    notify  => Service['slurmrestd'],
  }

  service { 'slurmrestd':
    ensure     => $slurm::slurmrestd_service_ensure,
    enable     => $slurm::slurmrestd_service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
