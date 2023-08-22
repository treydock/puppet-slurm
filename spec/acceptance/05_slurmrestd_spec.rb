# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'slurmrestd' do
  if ['docker', 'hyperv'].include?(fact('virtual'))
    let(:slurm_user) { 'root' }
  else
    let(:slurm_user) { 'slurm' }
  end

  context 'with default parameters' do
    nodes = hosts_as('slurmdbd')

    it 'runs successfully' do
      pp = <<-PP
      include mysql::server
      class { 'slurm':
        slurmctld  => true,
        slurmrestd => true,
      }
      PP

      apply_manifest_on(nodes, pp, catch_failures: true)
      if ['docker', 'hyperv'].include?(fact('virtual'))
        on nodes, 'chown root:root /run/munge'
      end
      apply_manifest_on(nodes, pp, catch_changes: true)
    end

    nodes.each do |node|
      it_behaves_like 'common::user', node
      unless RSpec.configuration.slurm_repo_baseurl.nil?
        it_behaves_like 'common::install-slurmrestd', node
      end
      it_behaves_like 'common::config', node
      it_behaves_like 'slurmrestd::service', node

      describe port(6820) do
        it { is_expected.to be_listening }
      end
    end
  end
end
