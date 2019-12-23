require 'spec_helper_acceptance'

describe 'slurm::client class:' do
  context 'default parameters' do
    nodes = hosts_as('slurm-client')

    it 'runs successfully' do
      pp = <<-EOS
      include slurm
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
        it_behaves_like 'common::install', node
      end
      it_behaves_like 'common::setup', node
      it_behaves_like 'common::config', node
    end

    describe command('sinfo'), node: nodes[0] do
      its(:stdout) { is_expected.to match %r{^general} }
    end

    describe command('sinfo -N'), node: nodes[0] do
      its(:stdout) { is_expected.to match %r{^slurmd} }
    end
  end
end
