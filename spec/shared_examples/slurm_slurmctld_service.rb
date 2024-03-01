# frozen_string_literal: true

shared_examples_for 'slurm::slurmctld::service' do
  it do
    is_expected.to contain_service('slurmctld').with(ensure: 'running',
                                                     enable: 'true',
                                                     hasstatus: 'true',
                                                     hasrestart: 'true')
  end

  it do
    is_expected.to contain_exec('scontrol reconfig').with(
      command: 'scontrol reconfig',
      path: '/usr/bin:/bin:/usr/sbin:/sbin',
      refreshonly: true,
    )
  end

  context 'when ignoring reconfig errors' do
    let(:param_override) { { reconfig_ignore_errors: true } }

    it do
      is_expected.to contain_exec('scontrol reconfig').with_command('scontrol reconfig || exit 0')
    end
  end
end
