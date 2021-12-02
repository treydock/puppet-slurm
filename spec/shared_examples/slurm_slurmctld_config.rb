shared_examples_for 'slurm::slurmctld::config' do
  it do
    is_expected.to contain_file('StateSaveLocation').with(ensure: 'directory',
                                                          path: '/var/spool/slurmctld.state',
                                                          owner: 'slurm',
                                                          group: 'slurm',
                                                          mode: '0700')
  end

  it { is_expected.not_to contain_mount('StateSaveLocation') }

  context 'when state_dir_nfs_device => "192.168.1.1:/slurm/state"' do
    let(:param_override) { { state_dir_nfs_device: '192.168.1.1:/slurm/state' } }

    it do
      is_expected.to contain_mount('StateSaveLocation').with(ensure: 'mounted',
                                                             name: '/var/spool/slurmctld.state',
                                                             atboot: 'true',
                                                             device: '192.168.1.1:/slurm/state',
                                                             fstype: 'nfs',
                                                             options: 'rw,sync,noexec,nolock,auto',
                                                             before: 'File[StateSaveLocation]')
    end
  end
end
