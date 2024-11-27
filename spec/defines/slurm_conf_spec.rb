# frozen_string_literal: true

require 'spec_helper'

describe 'slurm::conf' do
  on_supported_os(supported_os: [
                    {
                      'operatingsystem' => 'RedHat',
                      'operatingsystemrelease' => ['7'],
                    },
                  ]).each do |_os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'ascend' }
    let(:params) do
      {
        configs: {
          'ClusterName' => 'ascend',
          'SlurmctldHost' => 'ascend-slurm01.example.com',
        },
      }
    end

    it { is_expected.to create_concat('slurm-ascend.conf') }
    it { is_expected.to contain_class('slurm') }

    it do
      is_expected.to contain_concat__fragment('slurm-ascend.conf-config').with(
        target: 'slurm-ascend.conf',
        content: %r{ClusterName=ascend},
        order: '00',
      )
    end
  end
end
