# frozen_string_literal: true

shared_examples_for 'slurm::common::setup' do |facts|
  let(:syslog_pid) do
    if facts[:os]['release']['major'].to_s == '8'
      '/var/run/rsyslogd.pid'
    else
      '/var/run/syslogd.pid'
    end
  end

  it do
    is_expected.to contain_file('/etc/profile.d/slurm.sh').with(ensure: 'file',
                                                                path: '/etc/profile.d/slurm.sh',
                                                                owner: 'root',
                                                                group: 'root',
                                                                mode: '0644')
  end

  it do
    verify_contents(catalogue, '/etc/profile.d/slurm.sh', [
                      'export SLURM_CONF="/etc/slurm/slurm.conf"'
                    ])
  end

  it do
    is_expected.to contain_file('/etc/profile.d/slurm.csh').with(ensure: 'file',
                                                                 path: '/etc/profile.d/slurm.csh',
                                                                 owner: 'root',
                                                                 group: 'root',
                                                                 mode: '0644')
  end

  it do
    verify_contents(catalogue, '/etc/profile.d/slurm.csh', [
                      'setenv SLURM_CONF "/etc/slurm/slurm.conf"'
                    ])
  end

  it do
    is_expected.to contain_file('slurm CONFDIR').with(ensure: 'directory',
                                                      path: '/etc/slurm',
                                                      owner: 'root',
                                                      group: 'root',
                                                      mode: '0755')
  end

  it do
    if slurmctld || slurmd || slurmdbd
      is_expected.to contain_file('/var/log/slurm').with(ensure: 'directory',
                                                         owner: 'slurm',
                                                         group: 'slurm',
                                                         mode: '0700')
    else
      is_expected.not_to contain_file('/var/log/slurm')
    end
  end

  it do
    if slurmctld || slurmd || slurmdbd
      is_expected.to contain_logrotate__rule('slurm').with(path: '/var/log/slurm/*.log',
                                                           compress: 'true',
                                                           missingok: 'true',
                                                           copytruncate: 'false',
                                                           delaycompress: 'false',
                                                           ifempty: 'false',
                                                           rotate: '10',
                                                           sharedscripts: 'true',
                                                           size: '10M',
                                                           create: 'true',
                                                           create_mode: '0640',
                                                           create_owner: 'slurm',
                                                           create_group: 'root',
                                                           postrotate: [
                                                             'pkill -x --signal SIGUSR2 slurmctld',
                                                             'pkill -x --signal SIGUSR2 slurmd',
                                                             'pkill -x --signal SIGUSR2 slurmdbd',
                                                             'exit 0'
                                                           ])
    else
      is_expected.not_to contain_logrotate__rule('slurm')
    end
  end

  context 'when profile_d_env_vars defined' do
    let(:param_override) { { profile_d_env_vars: { 'FOO' => 'bar' } } }

    it do
      verify_contents(catalogue, '/etc/profile.d/slurm.sh', [
                        'export FOO="bar"'
                      ])
    end

    it do
      verify_contents(catalogue, '/etc/profile.d/slurm.csh', [
                        'setenv FOO "bar"'
                      ])
    end
  end

  context 'when manage_logrotate => false' do
    let(:param_override) {  { manage_logrotate: false } }

    it { is_expected.not_to contain_logrotate__rule('slurm') }
  end

  context 'when use_syslog => true' do
    let(:param_override) {  { use_syslog: true } }

    it do
      if slurmctld || slurmd || slurmdbd
        is_expected.to contain_logrotate__rule('slurm').with(
          postrotate: [
            "/bin/kill -HUP `cat #{syslog_pid} 2> /dev/null` 2> /dev/null || true",
            'exit 0'
          ],
        )
      else
        is_expected.not_to contain_logrotate__rule('slurm')
      end
    end

    context 'when SlurmSchedLogLevel is 1' do
      let(:param_override) { { use_syslog: true, slurm_conf_override: { 'SlurmSchedLogLevel' => '1' } } }

      it do
        if slurmctld
          is_expected.to contain_logrotate__rule('slurm').with(
            postrotate: [
              "/bin/kill -HUP `cat #{syslog_pid} 2> /dev/null` 2> /dev/null || true",
              'pkill -x --signal SIGUSR2 slurmctld',
              'exit 0'
            ],
          )
        end
      end
    end
  end
end
