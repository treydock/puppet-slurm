# frozen_string_literal: true

require 'spec_helper'
require 'facter/util/slurm'

describe 'slurm_core_count_per_cpu Fact' do
  before :each do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
    allow(File).to receive(:exists?).with('/proc/cpuinfo').and_return(true)
  end

  it 'returns 4 for Xeon E5420 dual socket' do
    allow(Facter::Util::Slurm).to receive(:read_procfs).with('/proc/cpuinfo').and_return(cpuinfo_fixture_read('xeon_E5420_dualsocket_cpuinfo'))
    expect(Facter.fact(:slurm_core_count_per_cpu).value).to eq(4)
  end

  it 'returns 4 AMD Opteron 6320' do
    allow(Facter::Util::Slurm).to receive(:read_procfs).with('/proc/cpuinfo').and_return(cpuinfo_fixture_read('amd_opteron_6320_quadsocket_cpuinfo'))
    expect(Facter.fact(:slurm_core_count_per_cpu).value).to eq(4)
  end

  it 'returns nil if can not parse' do
    allow(Facter::Util::Slurm).to receive(:read_procfs).with('/proc/cpuinfo').and_return('foobar')
    expect(Facter.fact(:slurm_core_count_per_cpu).value).to be_nil
  end

  it 'is nil if /proc/cpuinfo does not exist' do
    allow(Facter::Util::Slurm).to receive(:read_procfs).with('/proc/cpuinfo').and_return(nil)
    expect(Facter.fact(:slurm_core_count_per_cpu).value).to be_nil
  end
end
