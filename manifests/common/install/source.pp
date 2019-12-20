# @api private
class slurm::common::install::source {

  ensure_packages($slurm::source_dependencies)

  archive { "/usr/local/src/slurm-${slurm::version}.tar.bz2":
    source       => "https://download.schedmd.com/slurm/slurm-${slurm::version}.tar.bz2",
    extract      => true,
    extract_path => '/usr/local/src',
    creates      => "/usr/local/src/slurm-${slurm::version}",
    cleanup      => true,
    user         => 'root',
    group        => 'root',
    notify       => Exec['configure-slurm'],
  }

  $base_configure_flags = join([
    '--prefix=/usr',
    '--libdir=/usr/lib64',
    "--sysconfdir=${slurm::conf_dir}",
  ], ' ')
  $configure_flags = join($slurm::configure_flags, ' ')
  $configure_command = "./configure ${base_configure_flags} ${configure_flags}"

  exec { 'configure-slurm':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => $configure_command,
    cwd         => "/usr/local/src/slurm-${slurm::version}",
    refreshonly => true,
  }
  ~> exec { 'make-slurm':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => "make -j${facts['processors']['count']}",
    cwd         => "/usr/local/src/slurm-${slurm::version}",
    refreshonly => true,
  }
  ~> exec { 'make-install-slurm':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => 'make install',
    cwd         => "/usr/local/src/slurm-${slurm::version}",
    refreshonly => true,
  }
}
