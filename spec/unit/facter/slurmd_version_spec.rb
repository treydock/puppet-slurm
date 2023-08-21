# frozen_string_literal: true

require 'spec_helper'

describe 'slurmd_version fact' do
  before :each do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
  end

  it 'returns 19.05.3' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmd').and_return('/usr/sbin/slurmd')
    allow(Facter::Util::Resolution).to receive(:exec).with('timeout 2 /usr/sbin/slurmd -V 2>/dev/null').and_return('slurm 19.05.3')
    expect(Facter.fact(:slurmd_version).value).to eq('19.05.3')
  end

  it 'is nil if slurmd -V returns unexpected output' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmd').and_return('/usr/sbin/slurmd')
    allow(Facter::Util::Resolution).to receive(:exec).with('timeout 2 /usr/sbin/slurmd -V 2>/dev/null').and_return('')
    expect(Facter.fact(:slurmd_version).value).to be_nil
  end

  it 'is nil if slurmd not present' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmd').and_return(nil)
    expect(Facter.fact(:slurmd_version).value).to be_nil
  end
end
