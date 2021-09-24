shared_examples_for 'slurm::slurmrestd' do |facts|
  it { is_expected.to contain_class('slurm::common::user').that_comes_before('Class[slurm::common::install]') }
  it { is_expected.to contain_class('slurm::common::install').that_comes_before('Class[slurm::common::config]') }
  it { is_expected.to contain_class('slurm::common::config').that_comes_before('Class[slurm::slurmrestd::service]') }
  it { is_expected.to contain_class('slurm::slurmrestd::service') }

  it_behaves_like 'slurm::common::user'
  if facts[:os]['family'] == 'RedHat'
    it_behaves_like 'slurm::common::install::rpm-slurmrestd'
  end
  it_behaves_like 'slurm::common::config'
  it_behaves_like 'slurm::slurmrestd::service'
end
