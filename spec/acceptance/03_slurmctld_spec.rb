require 'spec_helper_acceptance'

describe 'slurmctld' do
  if ['docker', 'hyperv'].include?(fact('virtual'))
    let(:slurm_user) { 'root' }
  else
    let(:slurm_user) { 'slurm' }
  end

  context 'default parameters' do
    nodes = hosts_as('slurmctld')

    it 'runs successfully' do
      pp = <<-EOS
      class { 'slurm':
        client => false,
        slurmctld => true,
      }
      EOS

      apply_manifest_on(nodes, pp, catch_failures: true)
      if ['docker', 'hyperv'].include?(fact('virtual'))
        on nodes, 'chown root:root /run/munge'
      end
      apply_manifest_on(nodes, pp, catch_changes: true)
    end

    nodes.each do |node|
      it_behaves_like 'common::user', node
      unless RSpec.configuration.slurm_repo_baseurl.nil?
        it_behaves_like 'common::install', node
        it_behaves_like 'common::install-slurmctld', node
      end
      it_behaves_like 'common::setup', node
      it_behaves_like 'common::config', node
      it_behaves_like 'slurmctld::config', node
      it_behaves_like 'slurmctld::service', node
    end
  end
end
