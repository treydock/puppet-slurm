# frozen_string_literal: true

shared_examples_for 'slurm::slurmrestd::service' do
  it do
    is_expected.to contain_service('slurmrestd').with(ensure: 'running',
                                                      enable: 'true',
                                                      hasstatus: 'true',
                                                      hasrestart: 'true')
  end
end
