# @api private
class slurm::slurmdbd::service {

  file { '/etc/sysconfig/slurmdbd':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('slurm/sysconfig/slurmdbd.erb'),
  }

  if ! empty($slurm::slurmdbd_service_limits) {
    systemd::service_limits { 'slurmdbd.service':
      limits          => $slurm::sslurmdbd_service_limits,
      restart_service => false,
    }
  }

  if $slurm::slurmdbd_archive_dir_systemd {
    $systemd_mounts = 'present'
  } else {
    $systemd_mounts = 'absent'
  }
  systemd::dropin_file { 'slurmdbd-mounts.conf':
    ensure  => $systemd_mounts,
    unit    => 'slurmctld.service',
    content => join(delete_undef_values([
      '# File managed by Puppet',
      '[Unit]',
      $slurm::slurmdbd_archive_dir_systemd,
    ]), "\n"),
    notify  => Service['slurmdbd'],
  }

  if $slurm::slurmdbd_restart_on_failure {
    $slurmdbd_systemd_restart = 'present'
  } else {
    $slurmdbd_systemd_restart = 'absent'
  }

  systemd::dropin_file { 'slurmdbd-restart.conf':
    ensure  => $slurmdbd_systemd_restart,
    unit    => 'slurmdbd.service',
    content => join([
      '# File managed by Puppet',
      '[Service]',
      'Restart=on-failure',
    ], "\n"),
    notify  => Service['slurmdbd'],
  }

  service { 'slurmdbd':
    ensure     => $slurm::slurmdbd_service_ensure,
    enable     => $slurm::slurmdbd_service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

  include ::systemd::systemctl::daemon_reload
  Class['systemd::systemctl::daemon_reload'] -> Service['slurmdbd']
}
