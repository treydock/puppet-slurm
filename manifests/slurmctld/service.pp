# @api private
class slurm::slurmctld::service {

  file { "${slurm::env_dir}/slurmctld":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('slurm/sysconfig/slurmctld.erb'),
    notify  => Service['slurmctld'],
  }

  if ! empty($slurm::slurmctld_service_limits) {
    systemd::service_limits { 'slurmctld.service':
      limits          => $slurm::sslurmctld_service_limits,
      restart_service => false,
      notify          => Service['slurmctld'],
    }
  }

  if $slurm::state_dir_systemd {
    $systemd_mounts = 'present'
  } else {
    $systemd_mounts = 'absent'
  }
  systemd::dropin_file { 'slurmctld-mounts.conf':
    ensure  => $systemd_mounts,
    unit    => 'slurmctld.service',
    content => join(delete_undef_values([
      '# File managed by Puppet',
      '[Unit]',
      $slurm::state_dir_systemd,
    ]), "\n"),
    notify  => Service['slurmctld'],
  }

  if $slurm::slurmctld_restart_on_failure {
    $slurmctld_systemd_restart = 'present'
  } else {
    $slurmctld_systemd_restart = 'absent'
  }

  systemd::dropin_file { 'slurmctld-restart.conf':
    ensure  => $slurmctld_systemd_restart,
    unit    => 'slurmctld.service',
    content => join([
      '# File managed by Puppet',
      '[Service]',
      'Restart=on-failure',
    ], "\n"),
    notify  => Service['slurmctld'],
  }

  service { 'slurmctld':
    ensure     => $slurm::slurmctld_service_ensure,
    enable     => $slurm::slurmctld_service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

  exec { 'scontrol reconfig':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    refreshonly => true,
  }

  if $slurm::enable_configless {
    Service['slurmctld'] ~> Exec['scontrol reconfig']
  } else {
    Service['slurmctld'] -> Exec['scontrol reconfig']
  }

  if $slurm::restart_services {
    slurmctld_conn_validator { 'puppet':
      ensure  => 'present',
      timeout => $slurm::slurmctld_conn_validator_timeout,
      before  => Exec['scontrol reconfig'],
      require => Service['slurmctld'],
    }
  }
}
