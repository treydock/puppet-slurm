# frozen_string_literal: true

shared_examples_for 'common::user' do |node|
  describe group('slurm'), node: node, unless: ['docker', 'hyperv'].include?(fact('virtual')) do
    it { is_expected.to exist }
  end

  describe user('slurm'), node: node, unless: ['docker', 'hyperv'].include?(fact('virtual')) do
    it { is_expected.to exist }
  end
end
