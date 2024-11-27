# frozen_string_literal: true

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
      notify: 'Exec[install-slurm]',
    )
  end

  it do
    is_expected.to contain_file("/usr/local/src/slurm-#{params[:version]}/puppet-install.sh").with(
      ensure: 'file',
      owner: 'root',
      group: 'root',
      mode: '0755',
      notify: 'Exec[install-slurm]',
    )
  end

  it do
    verify_contents(catalogue, "/usr/local/src/slurm-#{params[:version]}/puppet-install.sh", [
                      './configure --prefix=/usr --libdir=/usr/lib64 --sysconfdir=/etc/slurm --enable-slurmrestd ',
                    ],)
  end

  it do
    is_expected.to contain_exec('install-slurm').with(
      path: "/usr/local/src/slurm-#{params[:version]}:/usr/bin:/bin:/usr/sbin:/sbin",
      command: "/usr/local/src/slurm-#{params[:version]}/puppet-install.sh",
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
