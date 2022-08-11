require 'spec_helper'

describe 'slurmctld_version fact' do
  before :each do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
  end

  let(:nodes) do
    <<~EOS
    p0005
    p0001
    p0001
    p0002
    p0003
    p0004
    p0004
    EOS
  end

  it 'returns list of nodes' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmctld').and_return('/usr/sbin/slurmctld')
    allow(Facter::Util::Resolution).to receive(:which).with('sinfo').and_return('/usr/bin/sinfo')
    allow(Facter::Util::Resolution).to receive(:exec).with('timeout 5 /usr/bin/sinfo -a -h -N -o \'%N\' 2>/dev/null').and_return(nodes)
    expect(Facter.fact(:slurm_nodes).value).to eq(['p0001','p0002','p0003','p0004','p0005'])
  end

  it 'is nil if sinfo returns unexpected output' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmctld').and_return('/usr/sbin/slurmctld')
    allow(Facter::Util::Resolution).to receive(:which).with('sinfo').and_return('/usr/bin/sinfo')
    allow(Facter::Util::Resolution).to receive(:exec).with('timeout 5 /usr/bin/sinfo -a -h -N -o \'%N\' 2>/dev/null').and_return(nil)
    expect(Facter.fact(:slurm_nodes).value).to be_nil
  end

  it 'is nil if sinfo not present' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmctld').and_return('/usr/sbin/slurmctld')
    allow(Facter::Util::Resolution).to receive(:which).with('sinfo').and_return(nil)
    expect(Facter.fact(:slurm_nodes).value).to be_nil
  end

  it 'is nil if slurmctld not present' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmctld').and_return(nil)
    allow(Facter::Util::Resolution).to receive(:which).with('sinfo').and_return('/usr/bin/sinfo')
    expect(Facter.fact(:slurm_nodes).value).to be_nil
  end
end
