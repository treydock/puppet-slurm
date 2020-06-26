require 'spec_helper'

describe 'slurm::gres' do
  on_supported_os(supported_os: [
                    {
                      'operatingsystem'        => 'RedHat',
                      'operatingsystemrelease' => ['7'],
                    },
                  ]).each do |_os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'gpu' }
    let(:params) { { node_name: 'slurmd01', file: '/dev/nvidia0' } }

    it { is_expected.to create_slurm__gres('gpu') }
    it { is_expected.to contain_class('slurm') }

    it do
      is_expected.to contain_concat__fragment('slurm-gres.conf-gpu').with(
        target: 'slurm-gres.conf',
        content: %r{NodeName=slurmd01 Name=gpu File=/dev/nvidia0},
        order: '50',
      )
    end
  end
end
