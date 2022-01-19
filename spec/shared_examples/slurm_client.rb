shared_examples_for 'slurm::client' do |facts|
  it { is_expected.to contain_class('munge') }
  it { is_expected.to contain_class('slurm::common::user').that_comes_before('Class[slurm::common::install]') }
  it { is_expected.to contain_class('slurm::common::install').that_comes_before('Class[slurm::common::setup]') }
  it { is_expected.to contain_class('slurm::common::setup').that_comes_before('Class[slurm::common::config]') }
  it { is_expected.to contain_class('slurm::common::config') }

  it_behaves_like 'slurm::common::user'
  if facts[:os]['family'] == 'Debian'
    it_behaves_like 'slurm::common::install::apt', facts
  else
    it_behaves_like 'slurm::common::install::rpm', facts
  end
  it_behaves_like 'slurm::common::setup', facts
  it_behaves_like 'slurm::common::config'
end
