require 'spec_helper'

describe 'slurmdbd_version fact' do
  before :each do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
  end

  it 'returns 19.05.3' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmdbd').and_return('/usr/sbin/slurmdbd')
    allow(Facter::Util::Resolution).to receive(:exec).with('timeout 2 /usr/sbin/slurmdbd -V 2>/dev/null').and_return('slurm 19.05.3')
    expect(Facter.fact(:slurmdbd_version).value).to eq('19.05.3')
  end

  it 'is nil if slurmdbd -V returns unexpected output' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmdbd').and_return('/usr/sbin/slurmdbd')
    allow(Facter::Util::Resolution).to receive(:exec).with('timeout 2 /usr/sbin/slurmdbd -V 2>/dev/null').and_return('')
    expect(Facter.fact(:slurmdbd_version).value).to be_nil
  end

  it 'is nil if slurmdbd not present' do
    allow(Facter::Util::Resolution).to receive(:which).with('slurmdbd').and_return(nil)
    expect(Facter.fact(:slurmdbd_version).value).to be_nil
  end
end
