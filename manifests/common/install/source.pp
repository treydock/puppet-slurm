# @api private
class slurm::common::install::source {
  if $slurm::osfamily == 'RedHat' {
    include epel
    $package_require = Yumrepo['epel']
  } else {
    $package_require = undef
  }

  ensure_packages($slurm::source_dependencies)
  $slurm::source_dependencies.each |$package| {
    if $package_require {
      $package_require -> Package[$package]
    }
    Package[$package] -> Archive[$slurm::src_file]
  }
  if ($facts['os']['family'] == 'Debian') or ($facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'], '8') >= 0) {
    if $slurm::source_install_manage_alternatives {
      if $facts['os']['family'] == 'Debian' {
        alternative_entry { '/usr/bin/python3':
          ensure   => 'present',
          altlink  => '/usr/bin/python',
          altname  => 'python',
          priority => 10,
          require  => Package['python3'],
          before   => Alternatives['python'],
        }
      }
      alternatives { 'python':
        path    => '/usr/bin/python3',
        require => Package['python3'],
        before  => Exec['install-slurm'],
      }
    }
  }

  archive { $slurm::src_file:
    source       => "https://download.schedmd.com/slurm/slurm-${slurm::version}.tar.bz2",
    extract      => true,
    extract_path => '/usr/local/src',
    creates      => $slurm::src_dir,
    cleanup      => true,
    user         => 'root',
    group        => 'root',
    notify       => Exec['install-slurm'],
  }

  $base_configure_flags = join([
    "--prefix=${slurm::install_prefix}",
    "--libdir=${slurm::install_prefix}/lib64",
    "--sysconfdir=${slurm::conf_dir}",
    '--enable-slurmrestd',
  ], ' ')
  $configure_flags = join($slurm::configure_flags, ' ')
  $configure_command = "./configure ${base_configure_flags} ${configure_flags}"

  file { "${slurm::src_dir}/puppet-install.sh":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => join([
      '#!/bin/bash',
      "cd ${slurm::src_dir}",
      $configure_command,
      '[ $? -ne 0 ] && { rm -f $0; exit 1; }',
      "make -j${facts['processors']['count']}",
      '[ $? -ne 0 ] && { rm -f $0; exit 1; }',
      'make install',
      '[ $? -ne 0 ] && { rm -f $0; exit 1; }',
      'exit 0',
      '',
    ], "\n"),
    notify  => Exec['install-slurm'],
    require => Archive[$slurm::src_file],
  }

  if $slurm::install_prefix != '/usr' {
    file { '/etc/ld.so.conf.d/slurm.conf':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "${slurm::install_prefix}/lib64\n",
      require => Exec['install-slurm'],
      notify  => Exec['ldconfig-slurm'],
    }
  }

  exec { 'install-slurm':
    path        => "${slurm::src_dir}:/usr/bin:/bin:/usr/sbin:/sbin",
    command     => "${slurm::src_dir}/puppet-install.sh",
    cwd         => $slurm::src_dir,
    refreshonly => true,
  }
  ~> exec { 'ldconfig-slurm':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => 'ldconfig',
    refreshonly => true,
  }
}
