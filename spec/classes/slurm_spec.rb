# frozen_string_literal: true

require 'spec_helper'

describe 'slurm' do
  on_supported_os.each do |os, os_facts|
    context "with #{os}" do
      let(:facts) do
        os_facts.merge('processors' => { 'count' => 1 })
      end
      let(:param_override) { {} }
      let(:client) { true }
      let(:slurmd) { false }
      let(:slurmctld) { false }
      let(:slurmdbd) { false }
      let(:database) { false }
      let(:slurmrestd) { false }
      let(:default_params) do
        {
          client: client,
          slurmd: slurmd,
          slurmctld: slurmctld,
          slurmdbd: slurmdbd,
          database: database,
          slurmrestd: slurmrestd,
          install_method: 'package'
        }
      end
      let(:params) { default_params.merge(param_override) }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('slurm::client') }
      it { is_expected.not_to contain_class('slurm::slurmd') }
      it { is_expected.not_to contain_class('slurm::slurmctld') }
      it { is_expected.not_to contain_class('slurm::slurmdbd') }
      it { is_expected.not_to contain_class('slurm::slurmdbd::db') }
      it { is_expected.not_to contain_class('slurm::slurmrestd') }

      it_behaves_like 'slurm::client', os_facts

      context 'when install from source' do
        let(:param_override) { { version: '20.02.0', install_method: 'source' } }

        it { is_expected.to compile.with_all_deps }

        it_behaves_like 'slurm::common::install::source', os_facts
      end

      context 'when install method is none' do
        let(:param_override) { { install_method: 'none' } }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.not_to contain_class('slurm::common::install::source') }
        it { is_expected.not_to contain_class('slurm::common::install::rpm') }
        it { is_expected.not_to contain_class('slurm::common::install::apt') }
      end

      context 'when slurmd' do
        let(:client) { false }
        let(:slurmd) { true }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('slurm::slurmd') }
        it { is_expected.not_to contain_class('slurm::slurmctld') }
        it { is_expected.not_to contain_class('slurm::slurmdbd') }
        it { is_expected.not_to contain_class('slurm::client') }
        it { is_expected.not_to contain_class('slurm::slurmdbd::db') }
        it { is_expected.not_to contain_class('slurm::slurmrestd') }

        it_behaves_like 'slurm::slurmd', os_facts
      end

      context 'when slurmctld' do
        let(:client) { false }
        let(:slurmctld) { true }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('slurm::slurmctld') }
        it { is_expected.not_to contain_class('slurm::slurmd') }
        it { is_expected.not_to contain_class('slurm::slurmdbd') }
        it { is_expected.not_to contain_class('slurm::client') }
        it { is_expected.not_to contain_class('slurm::slurmdbd::db') }
        it { is_expected.not_to contain_class('slurm::slurmrestd') }

        it_behaves_like 'slurm::slurmctld', os_facts
      end

      context 'when slurmdbd' do
        let(:client) { false }
        let(:slurmdbd) { true }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('slurm::slurmdbd') }
        it { is_expected.not_to contain_class('slurm::slurmd') }
        it { is_expected.not_to contain_class('slurm::slurmctld') }
        it { is_expected.not_to contain_class('slurm::client') }
        it { is_expected.not_to contain_class('slurm::slurmdbd::db') }
        it { is_expected.not_to contain_class('slurm::slurmrestd') }

        it_behaves_like 'slurm::slurmdbd', os_facts
      end

      context 'when database' do
        let(:pre_condition) { 'include ::mysql::server' }
        let(:client) { false }
        let(:database) { true }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('slurm::slurmdbd::db') }
        it { is_expected.not_to contain_class('slurm::slurmdbd') }
        it { is_expected.not_to contain_class('slurm::slurmd') }
        it { is_expected.not_to contain_class('slurm::slurmctld') }
        it { is_expected.not_to contain_class('slurm::client') }
        it { is_expected.not_to contain_class('slurm::slurmrestd') }

        it_behaves_like 'slurm::slurmdbd::db', os_facts
      end

      context 'when slurmrestd', unless: os_facts[:os]['family'] == 'Debian' do
        let(:client) { false }
        let(:slurmrestd) { true }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('slurm::slurmrestd') }
        it { is_expected.not_to contain_class('slurm::slurmd') }
        it { is_expected.not_to contain_class('slurm::slurmctld') }
        it { is_expected.not_to contain_class('slurm::client') }
        it { is_expected.not_to contain_class('slurm::slurmdbd') }
        it { is_expected.not_to contain_class('slurm::slurmdbd::db') }

        it_behaves_like 'slurm::slurmrestd', os_facts
      end
    end
  end
end
