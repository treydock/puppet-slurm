# @api private
class slurm::slurmd::service {

  file { "${slurm::env_dir}/slurmd":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('slurm/sysconfig/slurmd.erb'),
    notify  => Service['slurmd'],
  }

  if ! empty($slurm::slurmd_service_limits) {
    systemd::service_limits { 'slurmd.service':
      limits          => $slurm::slurmd_service_limits,
      restart_service => false,
      notify          => Service['slurmd'],
    }
  }

  service { 'slurmd':
    ensure     => $slurm::slurmd_service_ensure,
    enable     => $slurm::slurmd_service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

  exec { 'slurmd reload':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => 'systemctl reload slurmd',
    refreshonly => true,
    require     => Service['slurmd'],
  }
}
