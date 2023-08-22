# frozen_string_literal: true

shared_examples_for 'slurm::slurmdbd' do |facts|
  it { is_expected.to contain_class('munge') }
  it { is_expected.to contain_class('munge::service').that_comes_before('Class[slurm::slurmdbd::service]') }
  it { is_expected.to contain_class('slurm::common::user').that_comes_before('Class[slurm::common::install]') }
  it { is_expected.to contain_class('slurm::common::install').that_comes_before('Class[slurm::common::setup]') }
  it { is_expected.to contain_class('slurm::common::setup').that_comes_before('Class[slurm::common::config]') }
  it { is_expected.to contain_class('slurm::common::config').that_comes_before('Class[slurm::slurmdbd::config]') }
  it { is_expected.to contain_class('slurm::slurmdbd::config').that_comes_before('Class[slurm::slurmdbd::service]') }
  it { is_expected.to contain_class('slurm::slurmdbd::service') }

  it_behaves_like 'slurm::common::user'
  if facts[:os]['family'] == 'Debian'
    it_behaves_like 'slurm::common::install::apt-slurmdbd'
  else
    it_behaves_like 'slurm::common::install::rpm-slurmdbd'
  end
  it_behaves_like 'slurm::common::setup', facts
  it_behaves_like 'slurm::common::config'
  it_behaves_like 'slurm::slurmdbd::config'
  it_behaves_like 'slurm::slurmdbd::service'
end
