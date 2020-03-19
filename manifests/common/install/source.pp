# @api private
class slurm::common::install::source {
  $src_file = "/usr/local/src/slurm-${slurm::version}.tar.bz2"
  $src_dir = "/usr/local/src/slurm-${slurm::version}"

  ensure_packages($slurm::source_dependencies)
  if versioncmp($facts['os']['release']['major'], '8') >= 0 {
    if $slurm::source_install_manage_alternatives {
      alternatives { 'python':
        path   => '/usr/bin/python3',
        before => Exec['configure-slurm'],
      }
    }
  }

  archive { $src_file:
    source       => "https://download.schedmd.com/slurm/slurm-${slurm::version}.tar.bz2",
    extract      => true,
    extract_path => '/usr/local/src',
    creates      => $src_dir,
    cleanup      => true,
    user         => 'root',
    group        => 'root',
    notify       => Exec['configure-slurm'],
  }

  $base_configure_flags = join([
    "--prefix=${slurm::install_prefix}",
    "--libdir=${slurm::install_prefix}/lib64",
    "--sysconfdir=${slurm::conf_dir}",
  ], ' ')
  $configure_flags = join($slurm::configure_flags, ' ')
  $configure_command = "configure ${base_configure_flags} ${configure_flags}"

  file { "${src_dir}/configure.cmd":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => $configure_command,
    notify  => Exec['configure-slurm'],
    require => Archive[$src_file],
  }

  if $slurm::install_prefix != '/usr' {
    file { '/etc/ld.so.conf.d/slurm.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "${slurm::install_prefix}/lib64\n",
      require => Exec['make-install-slurm'],
      notify  => Exec['ldconfig-slurm'],
    }
  }

  exec { 'configure-slurm':
    path        => "${src_dir}:/usr/bin:/bin:/usr/sbin:/sbin",
    command     => "${configure_command} || rm -f configure.cmd",
    cwd         => $src_dir,
    refreshonly => true,
  }
  ~> exec { 'make-slurm':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => "make -j${facts['processors']['count']}",
    cwd         => $src_dir,
    refreshonly => true,
  }
  ~> exec { 'make-install-slurm':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => 'make install',
    cwd         => $src_dir,
    refreshonly => true,
  }
  ~> exec { 'ldconfig-slurm':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => 'ldconfig',
    refreshonly => true,
  }

  if $slurm::slurmd {
    systemd::unit_file { 'slurmd.service':
      source  => "file:///${src_dir}/etc/slurmd.service",
      require => Exec['make-install-slurm'],
      notify  => Service['slurmd'],
    }
  }
  if $slurm::slurmctld {
    systemd::unit_file { 'slurmctld.service':
      source  => "file:///${src_dir}/etc/slurmctld.service",
      require => Exec['make-install-slurm'],
      notify  => Service['slurmctld'],
    }
  }
  if $slurm::slurmdbd {
    systemd::unit_file { 'slurmdbd.service':
      source  => "file:///${src_dir}/etc/slurmdbd.service",
      require => Exec['make-install-slurm'],
      notify  => Service['slurmdbd'],
    }
  }
}
