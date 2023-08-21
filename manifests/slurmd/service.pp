# @api private
class slurm::slurmd::service {
  if $slurm::conf_server {
    $conf_option = "--conf-server ${slurm::conf_server}"
  } elsif $slurm::configless {
    $conf_option = undef
  } else {
    $conf_option = "-f ${slurm::slurm_conf_path}"
  }
  $slurmd_options = [
    $conf_option,
    '-M',
    $slurm::slurmd_options,
  ].filter |$c| { $c =~ NotUndef }.join(' ')

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

  systemd::dropin_file { 'slurmd-logging.conf':
    ensure         => $slurm::logging_systemd_override,
    unit           => 'slurmd.service',
    content        => join([
        '# File managed by Puppet',
        '[Service]',
        'StandardOutput=null',
        'StandardError=null',
    ], "\n"),
    notify_service => false,
    notify         => Service['slurmd'],
  }

  if $slurm::install_method == 'source' {
    systemd::unit_file { 'slurmd.service':
      source  => "file:///${slurm::src_dir}/etc/slurmd.service",
      require => Exec['install-slurm'],
      notify  => Service['slurmd'],
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
