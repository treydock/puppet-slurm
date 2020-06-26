shared_examples_for 'slurm::slurmrestd' do
  it { is_expected.to contain_class('slurm::common::user').that_comes_before('Class[slurm::common::install]') }
  it { is_expected.to contain_class('slurm::common::install').that_comes_before('Class[slurm::common::config]') }
  it { is_expected.to contain_class('slurm::common::config').that_comes_before('Class[slurm::slurmrestd::service]') }
  it { is_expected.to contain_class('slurm::slurmrestd::service') }
\
  it_behaves_like 'slurm::common::user'
  it_behaves_like 'slurm::common::install::rpm-slurmrestd'
  it_behaves_like 'slurm::common::config'
  it_behaves_like 'slurm::slurmrestd::service'
end
