# @api private
class slurm::slurmctld::service {
  $slurmctld_options = [
    "-f ${slurm::slurm_conf_path}",
    $slurm::slurmctld_options,
  ].filter |$c| { $c =~ NotUndef }.join(' ')

  file { "${slurm::env_dir}/slurmctld":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('slurm/sysconfig/slurmctld.erb'),
    notify  => Service['slurmctld'],
  }

  if ! empty($slurm::slurmctld_service_limits) {
    systemd::manage_dropin { 'slurmctld.service-90-limits.conf':
      ensure         => present,
      unit           => 'slurmctld.service',
      filename       => '90-limits.conf',
      service_entry  => $slurm::slurmctld_service_limits,
      notify_service => true,
    }
  }

  if $slurm::state_dir_systemd {
    $systemd_mounts = 'present'
  } else {
    $systemd_mounts = 'absent'
  }
  systemd::dropin_file { 'slurmctld-mounts.conf':
    ensure         => $systemd_mounts,
    unit           => 'slurmctld.service',
    content        => join(delete_undef_values([
          '# File managed by Puppet',
          '[Unit]',
          $slurm::state_dir_systemd,
    ]), "\n"),
    notify_service => false,
    notify         => Service['slurmctld'],
  }

  if $slurm::slurmctld_restart_on_failure {
    $slurmctld_systemd_restart = 'present'
  } else {
    $slurmctld_systemd_restart = 'absent'
  }

  systemd::dropin_file { 'slurmctld-restart.conf':
    ensure         => $slurmctld_systemd_restart,
    unit           => 'slurmctld.service',
    content        => join([
        '# File managed by Puppet',
        '[Service]',
        'Restart=on-failure',
    ], "\n"),
    notify_service => false,
    notify         => Service['slurmctld'],
  }

  systemd::dropin_file { 'slurmctld-logging.conf':
    ensure         => $slurm::logging_systemd_override,
    unit           => 'slurmctld.service',
    content        => join([
        '# File managed by Puppet',
        '[Service]',
        'StandardOutput=null',
        'StandardError=null',
    ], "\n"),
    notify_service => false,
    notify         => Service['slurmctld'],
  }

  if $slurm::install_method == 'source' {
    systemd::unit_file { 'slurmctld.service':
      source  => "file:///${slurm::src_dir}/etc/slurmctld.service",
      require => Exec['install-slurm'],
      notify  => Service['slurmctld'],
    }
  }

  service { 'slurmctld':
    ensure     => $slurm::slurmctld_service_ensure,
    enable     => $slurm::slurmctld_service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

  if $slurm::reconfig_ignore_errors {
    $reconfig_command = 'scontrol reconfig || exit 0'
  } else {
    $reconfig_command = 'scontrol reconfig'
  }

  exec { 'scontrol reconfig':
    command     => $reconfig_command,
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
