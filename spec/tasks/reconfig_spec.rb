require 'spec_helper'
require 'open3'
require_relative '../../tasks/reconfig.rb'

describe SlurmReconfig do
  describe 'execute' do
    it 'should execute scontrol' do
      expect(Open3).to receive(:capture3).with('scontrol reconfig').and_return(['','', 0])
      ret = described_class.execute('scontrol')
      expect(ret).to eq({out: '', err: '', exit: 0})
    end
  end

  describe 'run' do
    it 'should execute scontrol' do
      allow(STDIN).to receive(:read).and_return('{}')
      expect(described_class).to receive(:execute).with('scontrol').and_return({out: '', err: '', exit: 0})
      described_class.run
    end
  end
end
