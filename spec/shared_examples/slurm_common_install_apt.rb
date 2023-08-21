# frozen_string_literal: true

shared_examples_for 'slurm::common::install::apt' do |facts|
  base_packages(facts).each do |p|
    it { is_expected.to contain_package(p).with_ensure('present').without_require }
  end

  it { is_expected.not_to contain_package('slurm-wlm-torque') }

  context 'when version => "20.02.0-1.el7"' do
    let(:param_override) { { package_ensure: '20.02.0' } }

    base_packages(facts).each do |p|
      it { is_expected.to contain_package(p).with_ensure('20.02.0').without_require }
    end
  end

  context 'when install_pam => false' do
    let(:param_override) {  { install_pam: false } }

    it { is_expected.not_to contain_package('libpam-slurm') }
  end

  context 'when install_torque_wrapper => true' do
    let(:param_override) {  { install_torque_wrapper: true } }

    it { is_expected.to contain_package('slurm-wlm-torque') }
  end
end

shared_examples_for 'slurm::common::install::apt-slurmd' do
  it { is_expected.to contain_package('slurmd').with_ensure('present').without_require }
end
shared_examples_for 'slurm::common::install::apt-slurmctld' do
  it { is_expected.to contain_package('slurmctld').with_ensure('present').without_require }
end
shared_examples_for 'slurm::common::install::apt-slurmdbd' do
  it { is_expected.to contain_package('slurmdbd').with_ensure('present').without_require }
end
