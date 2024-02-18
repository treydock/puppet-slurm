# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'slurmdbd' do
  let(:slurm_user) { 'slurm' }

  context 'with default parameters' do
    nodes = hosts_as('slurmdbd')

    it 'runs successfully' do
      pp = <<-PP
      include mysql::server
      class { 'slurm':
        client => false,
        slurmdbd => true,
        database => true,
      }
      PP

      apply_manifest_on(nodes, pp, catch_failures: true)
      if fact('virtual') == 'docker'
        on nodes, 'chown root:root /run/munge'
      end
      apply_manifest_on(nodes, pp, catch_changes: true)
    end

    nodes.each do |node|
      it_behaves_like 'common::user', node
      unless RSpec.configuration.slurm_repo_baseurl.nil?
        it_behaves_like 'common::install-slurmdbd', node
      end
      it_behaves_like 'common::setup', node
      it_behaves_like 'common::config', node
      it_behaves_like 'slurmdbd::config', node
      it_behaves_like 'slurmdbd::service', node
    end
  end
end
