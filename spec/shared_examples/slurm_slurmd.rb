shared_examples_for 'slurm::slurmd' do
  it { is_expected.to contain_class('munge') }
  it { is_expected.to contain_class('munge::service').that_comes_before('Class[slurm::slurmd::service]') }
  it { is_expected.to contain_class('slurm::common::user').that_comes_before('Class[slurm::common::install]') }
  it { is_expected.to contain_class('slurm::common::install').that_comes_before('Class[slurm::common::setup]') }
  it { is_expected.to contain_class('slurm::common::setup').that_comes_before('Class[slurm::common::config]') }
  it { is_expected.to contain_class('slurm::common::config').that_comes_before('Class[slurm::slurmd::config]') }
  it { is_expected.to contain_class('slurm::slurmd::config').that_comes_before('Class[slurm::slurmd::service]') }
  it { is_expected.to contain_class('slurm::slurmd::service') }

  it_behaves_like 'slurm::common::user'
  it_behaves_like 'slurm::common::install::rpm'
  it_behaves_like 'slurm::common::install::rpm-slurmd'
  it_behaves_like 'slurm::common::setup'
  it_behaves_like 'slurm::common::config'
  it_behaves_like 'slurm::slurmd::config'
  it_behaves_like 'slurm::slurmd::service'

  it do
    is_expected.to contain_firewall('100 allow access to slurmd').with(proto: 'tcp',
                                                                       dport: '6818',
                                                                       action: 'accept')
  end

  context 'when manage_firewall => false' do
    let(:params) { param_override.merge(manage_firewall: false) }

    it { is_expected.not_to contain_firewall('100 allow access to slurmd') }
  end
end
