# frozen_string_literal: true

shared_examples_for 'slurmrestd::service' do |node|
  describe service('slurmrestd'), node: node do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
