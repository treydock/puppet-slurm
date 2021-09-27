require 'spec_helper'

describe 'slurm::job_container' do
  on_supported_os(supported_os: [
                    {
                      'operatingsystem'        => 'RedHat',
                      'operatingsystemrelease' => ['7'],
                    },
                  ]).each do |_os, os_facts|
    let(:facts) { os_facts }
    let(:title) { '/dev/shm' }
    let(:params) { { auto_base_path: true, base_path: '/dev/shm/slurm' } }

    it { is_expected.to create_slurm__job_container('/dev/shm') }
    it { is_expected.to contain_class('slurm') }

    it do
      is_expected.to contain_concat__fragment('job_container.conf-/dev/shm').with(
        target: 'job_container.conf',
        content: "AutoBasePath=true\nBasePath=/dev/shm/slurm",
        order: '50',
      )
    end

    context 'with node_name defined' do
      let(:params) { { node_name: 'foo', auto_base_path: true, base_path: '/dev/shm/slurm' } }

      it do
        is_expected.to contain_concat__fragment('job_container.conf-/dev/shm').with(
          target: 'job_container.conf',
          content: "NodeName=foo AutoBasePath=true BasePath=/dev/shm/slurm\n",
          order: '50',
        )
      end
    end
  end
end
