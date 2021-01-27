require 'spec_helper'

describe 'slurm::spank' do
  on_supported_os(supported_os: [
                    {
                      'operatingsystem'        => 'RedHat',
                      'operatingsystemrelease' => ['7'],
                    },
                  ]).each do |_os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'x11' }
    let(:params) { {} }
    let(:pre_condition) { "class { 'slurm': slurmd => true }" }

    it { is_expected.to create_slurm__spank('x11') }
    it { is_expected.to contain_class('slurm') }

    it do
      is_expected.to contain_package('SLURM SPANK x11 package').only_with(ensure: 'installed',
                                                                          name: 'slurm-spank-x11',
                                                                          notify: [])
    end

    it do
      is_expected.to contain_concat__fragment('plugstack.conf-x11').only_with(
        target: 'plugstack.conf',
        content: %r{^optional x11.so$},
        order: '50',
        require: 'Package[SLURM SPANK x11 package]',
      )
    end

    context 'when required => true' do
      let(:params) { { required: true } }

      it do
        verify_fragment_contents(catalogue, 'plugstack.conf-x11', [
                                   'required x11.so',
                                 ])
      end
    end

    context 'when manage_package => false' do
      let(:params) { { manage_package: false } }

      it { is_expected.not_to contain_package('SLURM SPANK x11 package') }
    end

    context 'when arguments specified as Hash' do
      let(:params) { { arguments: { 'ssh_cmd' => 'ssh', 'helpertask_cmd' => '2>/tmp/log' } } }

      it do
        verify_fragment_contents(catalogue, 'plugstack.conf-x11', [
                                   'optional x11.so ssh_cmd=ssh helpertask_cmd=2>/tmp/log',
                                 ])
      end
    end

    context 'when arguments specified as Array' do
      let(:params) { { arguments: ['ssh_cmd=ssh', 'helpertask_cmd=2>/tmp/log'] } }

      it do
        verify_fragment_contents(catalogue, 'plugstack.conf-x11', [
                                   'optional x11.so ssh_cmd=ssh helpertask_cmd=2>/tmp/log',
                                 ])
      end
    end

    context 'when arguments specified as String' do
      let(:params) { { arguments: 'helpertask_cmd=2>/tmp/log ssh_cmd=ssh' } }

      it do
        verify_fragment_contents(catalogue, 'plugstack.conf-x11', [
                                   'optional x11.so helpertask_cmd=2>/tmp/log ssh_cmd=ssh',
                                 ])
      end
    end

    describe 'configless' do
      let(:pre_condition) { "class { 'slurm': slurmd => true, configless => true }" }

      it 'works without error' do
        is_expected.to create_slurm__spank('x11')
      end
    end

    describe 'auks example' do
      let(:title) { 'auks' }
      let(:params) do
        {
          required: true,
          arguments: {
            'conf' => '/etc/auks/auks.conf',
            'default' => 'enabled',
            'spankstackcred' => 'no',
            'minimum_uid' => '0',
          },
          package_name: 'auks-slurm',
        }
      end

      it { is_expected.to contain_package('SLURM SPANK auks package').with_name('auks-slurm') }

      it do
        verify_fragment_contents(catalogue, 'plugstack.conf-auks', [
                                   'required auks.so conf=/etc/auks/auks.conf default=enabled spankstackcred=no minimum_uid=0',
                                 ])
      end
    end
  end
end
