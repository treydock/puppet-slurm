shared_examples_for 'slurm::common::install::source' do
  it { is_expected.to contain_class('slurm::common::install::source') }

  it do
    is_expected.to contain_archive("/usr/local/src/slurm-#{params[:version]}.tar.bz2").with(
      source: "https://download.schedmd.com/slurm/slurm-#{params[:version]}.tar.bz2",
      extract: 'true',
      extract_path: '/usr/local/src',
      creates: "/usr/local/src/slurm-#{params[:version]}",
      cleanup: 'true',
      user: 'root',
      group: 'root',
      notify: 'Exec[configure-slurm]',
    )
  end

  it do
    is_expected.to contain_file("/usr/local/src/slurm-#{params[:version]}/configure.cmd").with(
      ensure: 'file',
      owner: 'root',
      group: 'root',
      mode: '0600',
      content: 'configure --prefix=/usr --libdir=/usr/lib64 --sysconfdir=/etc/slurm --disable-slurmrestd ',
      notify: 'Exec[configure-slurm]',
    )
  end

  it do
    is_expected.to contain_exec('configure-slurm').with(
      path: "/usr/local/src/slurm-#{params[:version]}:/usr/bin:/bin:/usr/sbin:/sbin",
      command: 'configure --prefix=/usr --libdir=/usr/lib64 --sysconfdir=/etc/slurm --disable-slurmrestd  || rm -f configure.cmd',
      cwd: "/usr/local/src/slurm-#{params[:version]}",
      refreshonly: 'true',
      notify: ['Exec[make-slurm]'],
    )
  end
  it do
    is_expected.to contain_exec('make-slurm').with(
      path: '/usr/bin:/bin:/usr/sbin:/sbin',
      command: 'make -j1',
      cwd: "/usr/local/src/slurm-#{params[:version]}",
      refreshonly: 'true',
      notify: ['Exec[make-install-slurm]'],
    )
  end
  it do
    is_expected.to contain_exec('make-install-slurm').with(
      path: '/usr/bin:/bin:/usr/sbin:/sbin',
      command: 'make install',
      cwd: "/usr/local/src/slurm-#{params[:version]}",
      refreshonly: 'true',
      notify: ['Exec[ldconfig-slurm]'],
    )
  end
  it do
    is_expected.to contain_exec('ldconfig-slurm').with(
      path: '/usr/bin:/bin:/usr/sbin:/sbin',
      command: 'ldconfig',
      refreshonly: 'true',
    )
  end
end
