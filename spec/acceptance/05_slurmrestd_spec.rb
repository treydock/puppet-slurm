require 'spec_helper_acceptance'

describe 'slurmrestd' do
  if fact('virtual') == 'docker'
    let(:slurm_user) { 'root' }
  else
    let(:slurm_user) { 'slurm' }
  end

  context 'default parameters' do
    nodes = hosts_as('slurmdbd')

    it 'runs successfully' do
      pp = <<-EOS
      include mysql::server
      class { 'slurm':
        slurmrestd => true,
      }
      EOS

      apply_manifest_on(nodes, pp, catch_failures: true)
      if fact('virtual') == 'docker'
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
        it { is_expected.to be_listening.on('0.0.0.0').with('tcp') }
      end
    end
  end
end
