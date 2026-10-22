# frozen_string_literal: true

require 'spec_helper'

describe 'slurm_version fact' do
  before :each do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
  end

  it 'returns 19.05.3' do
    allow(Facter::Core::Execution).to receive(:which).with('sinfo').and_return('/usr/bin/sinfo')
    allow(Facter::Core::Execution).to receive(:execute).with('timeout 2 /usr/bin/sinfo -V 2>/dev/null').and_return('slurm 19.05.3')
    expect(Facter.fact(:slurm_version).value).to eq({ 'full' => '19.05.3', 'major' => '19.05' })
  end

  it 'is nil if sinfo -V returns unexpected output' do
    allow(Facter::Core::Execution).to receive(:which).with('sinfo').and_return('/usr/bin/sinfo')
    allow(Facter::Core::Execution).to receive(:execute).with('timeout 2 /usr/bin/sinfo -V 2>/dev/null').and_return('')
    expect(Facter.fact(:slurm_version).value).to be_empty
  end

  it 'is nil if sinfo not present' do
    allow(Facter::Core::Execution).to receive(:which).with('sinfo').and_return(nil)
    expect(Facter.fact(:slurm_version).value).to be_empty
  end
end
