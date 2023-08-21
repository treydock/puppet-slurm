# frozen_string_literal: true

require 'spec_helper'

describe 'slurm::nodeset' do
  on_supported_os(supported_os: [
                    {
                      'operatingsystem' => 'RedHat',
                      'operatingsystemrelease' => ['7']
                    }
                  ]).each do |_os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'test' }
    let(:params) { { feature: 'gpu' } }

    it { is_expected.to create_slurm__nodeset('test') }
    it { is_expected.to contain_class('slurm') }

    it do
      is_expected.to contain_concat__fragment('slurm.conf-nodeset-test').with(
        target: 'slurm.conf',
        content: "NodeSet=test Feature=gpu\n",
        order: '40',
      )
    end
  end
end
