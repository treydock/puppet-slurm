# frozen_string_literal: true

require 'spec_helper'
require 'open3'
require_relative '../../tasks/reconfig'

describe SlurmReconfig do
  describe 'execute' do
    it 'executes scontrol' do
      allow(Open3).to receive(:capture3).with('scontrol reconfig').and_return(['', '', 0])
      ret = described_class.execute('scontrol')
      expect(ret).to eq(out: '', err: '', exit: 0)
    end
  end

  describe 'run' do
    it 'executes scontrol' do
      allow($stdin).to receive(:read).and_return('{}')
      allow(described_class).to receive(:execute).with('scontrol').and_return(out: '', err: '', exit: 0)
      described_class.run
    end
  end
end
