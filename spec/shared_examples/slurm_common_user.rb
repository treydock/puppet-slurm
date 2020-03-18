shared_examples_for 'slurm::common::user' do
  it do
    is_expected.to contain_group('slurm').with(ensure: 'present',
                                               name: 'slurm',
                                               gid: nil,
                                               forcelocal: 'true',
                                               system: 'true')
  end

  it do
    is_expected.to contain_user('slurm').with(ensure: 'present',
                                              name: 'slurm',
                                              uid: nil,
                                              gid: 'slurm',
                                              shell: '/sbin/nologin',
                                              home: '/var/lib/slurm',
                                              managehome: 'true',
                                              comment: 'SLURM User',
                                              forcelocal: 'true',
                                              system: 'true')
  end

  context 'when slurm_group_gid => 400' do
    let(:params) { param_override.merge(slurm_group_gid: 400) }

    it { is_expected.to contain_group('slurm').with_gid('400') }
  end

  context 'when slurm_user_uid => 400' do
    let(:params) { param_override.merge(slurm_user_uid: 400) }

    it { is_expected.to contain_user('slurm').with_uid('400') }
  end

  context 'when manage_slurm_user => false' do
    let(:params) { param_override.merge(manage_slurm_user: false) }

    it { is_expected.not_to contain_group('slurm') }
    it { is_expected.not_to contain_user('slurm') }
  end
end
