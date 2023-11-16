# frozen_string_literal: true

def packages
  if fact('os.family') == 'Debian'
    {
      common: [
        'libslurm-dev',
        'libslurm-perl',
        'libpmi0',
        'libpmi2-0',
        'slurm-client'
      ],
      slurmd: 'slurmd',
      slurmctld: 'slurmctld',
      slurmdbd: 'slurmdbd',
      slurmrestd: nil
    }
  else
    {
      common: [
        'slurm',
        'slurm-contribs',
        'slurm-devel',
        'slurm-example-configs',
        'slurm-perlapi',
        'slurm-libpmi',
        'slurm-pam_slurm'
      ],
      slurmd: 'slurm-slurmd',
      slurmctld: 'slurm-slurmctld',
      slurmdbd: 'slurm-slurmdbd',
      slurmrestd: 'slurm-slurmrestd'
    }
  end
end
shared_examples_for 'common::install' do |node|
  packages[:common].each do |p|
    describe package(p), node: node do
      it { is_expected.to be_installed.with_version(RSpec.configuration.slurm_version.to_s) }
    end
  end
end

shared_examples_for 'common::install-slurmd' do |node|
  describe package(packages[:slurmd]), node: node do
    it { is_expected.to be_installed.with_version(RSpec.configuration.slurm_version.to_s) }
  end
end

shared_examples_for 'common::install-slurmctld' do |node|
  describe package(packages[:slurmctld]), node: node do
    it { is_expected.to be_installed.with_version(RSpec.configuration.slurm_version.to_s) }
  end
end

shared_examples_for 'common::install-slurmdbd' do |node|
  describe package(packages[:slurmdbd]), node: node do
    it { is_expected.to be_installed.with_version(RSpec.configuration.slurm_version.to_s) }
  end
end

shared_examples_for 'common::install-slurmrestd' do |node|
  describe package(packages[:slurmrestd]), node: node, unless: packages[:slurmrestd].nil? do
    it { is_expected.to be_installed.with_version(RSpec.configuration.slurm_version.to_s) }
  end
end
