# frozen_string_literal: true

shared_examples_for 'slurm::common::install::rpm' do |facts|
  base_packages(facts).each do |p|
    it { is_expected.to contain_package(p).with_ensure('present').without_require }
  end

  it { is_expected.not_to contain_yumrepo('slurm') }
  it { is_expected.not_to contain_package('slurm-torque') }

  context 'when version => "20.02.0-1.el7"' do
    let(:param_override) { { package_ensure: '20.02.0-1.el7' } }

    base_packages(facts).each do |p|
      it { is_expected.to contain_package(p).with_ensure('20.02.0-1.el7').without_require }
    end
  end

  context 'when repo_baseurl defined' do
    let(:param_override) { { repo_baseurl: 'http://foo' } }

    it { is_expected.to contain_yumrepo('slurm').with_baseurl('http://foo') }

    base_packages(facts).each do |p|
      it { is_expected.to contain_package(p).with_ensure('present').with_require('Yumrepo[slurm]') }
    end
  end

  context 'when install_pam => false' do
    let(:param_override) {  { install_pam: false } }

    it { is_expected.not_to contain_package('slurm-pam_slurm') }
  end

  context 'when install_torque_wrapper => true' do
    let(:param_override) {  { install_torque_wrapper: true } }

    it { is_expected.to contain_package('slurm-torque') }
  end
end

shared_examples_for 'slurm::common::install::rpm-slurmd' do
  it { is_expected.to contain_package('slurm-slurmd').with_ensure('present').without_require }
end
shared_examples_for 'slurm::common::install::rpm-slurmctld' do
  it { is_expected.to contain_package('slurm-slurmctld').with_ensure('present').without_require }
end
shared_examples_for 'slurm::common::install::rpm-slurmdbd' do
  it { is_expected.to contain_package('slurm-slurmdbd').with_ensure('present').without_require }
end
shared_examples_for 'slurm::common::install::rpm-slurmrestd' do
  it { is_expected.to contain_package('slurm-slurmrestd').with_ensure('present').without_require }
end
