# frozen_string_literal: true

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  c.add_setting :slurm_repo_baseurl
  c.slurm_repo_baseurl = ENV['SLURM_BEAKER_repo_baseurl'] || nil

  c.add_setting :slurm_version
  c.slurm_version = ENV['SLURM_BEAKER_version'] || '23.11.5'

  if ENV['BEAKER_set'] =~ %r{cluster}
    slurmctld_host = 'slurmctld'
    slurmdbd_host = 'slurmdbd'
  else
    slurmctld_host = 'slurm'
    slurmdbd_host = 'slurm'
  end

  slurmd_ip = find_only_one(:slurmd).ip
  on hosts, puppet('resource', 'host', 'slurmd', 'ensure=absent')
  on hosts, puppet('resource', 'host', 'slurmd', "ip=#{slurmd_ip}", 'host_aliases=slurm')

  install_method_hiera = if RSpec.configuration.slurm_repo_baseurl.nil?
                           'slurm::install_method: source'
                         else
                           "slurm::repo_baseurl: '#{RSpec.configuration.slurm_repo_baseurl}'"
                         end

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    copy_module_to(hosts, source: File.join(proj_root, 'spec/fixtures/site_slurm'), module_name: 'site_slurm', ignore_list: [])

    # Dependencies for NHC
    on hosts, puppet('module', 'install', 'puppetlabs-vcsrepo'), acceptable_exit_codes: [0, 1]
    on hosts, puppet('module', 'install', 'puppet-yum', '--version=">=6.0.0 <7.0.0"'), acceptable_exit_codes: [0, 1]
    # Add soft dependencies
    on hosts, puppet('module', 'install', 'treydock-nhc', '--version=5.0.0'), acceptable_exit_codes: [0, 1]
    on hosts, puppet('module', 'install', 'saz-rsyslog'), acceptable_exit_codes: [0, 1]

    hiera_yaml = <<-HIERA
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: osfamily-osmajor
    path: "%{facts.os.family}%{facts.os.release.major}.yaml"
  - name: virtual
    path: "%{facts.virtual}.yaml"
  - name: "Munge"
    path: "munge.yaml"
  - name: "common"
    path: "common.yaml"
    HIERA
    common_yaml = <<-HIERA
munge::munge_key_source: 'puppet:///modules/site_slurm/munge.key'
#{install_method_hiera}
slurm::version: '#{RSpec.configuration.slurm_version}'
slurm::slurmctld_host: '#{slurmctld_host}'
slurm::slurmdbd_host: '#{slurmdbd_host}'
slurm::slurmd_options: '-N slurmd'
slurm::manage_firewall: false
slurm::slurm_conf_override:
  JobAcctGatherType: 'jobacct_gather/linux'
  ProctrackType: 'proctrack/linuxproc'
  TaskPlugin: 'task/affinity'
slurm::auth_alt_types:
  - auth/jwt
slurm::jwt_key_source: 'puppet:///modules/site_slurm/jwt.key'
slurm::partitions:
  general:
    default: 'YES'
    nodes: 'slurmd'
slurm::nodes:
  slurmd:
    cpus: 1
    HIERA
    rhel7_yaml = <<-RHEL7
slurm::cgroup_plugin: 'cgroup/v1'
    RHEL7
    create_remote_file(hosts, '/etc/puppetlabs/puppet/hiera.yaml', hiera_yaml)
    on hosts, 'mkdir -p /etc/puppetlabs/puppet/data'
    create_remote_file(hosts, '/etc/puppetlabs/puppet/data/common.yaml', common_yaml)
    create_remote_file(hosts, '/etc/puppetlabs/puppet/data/RedHat7.yaml', rhel7_yaml)
    # Hack to work around issues with recent systemd and docker and running services as non-root
    if fact('os.family') == 'RedHat' && fact('os.release.major').to_i >= 7
      service_hack = <<-HACK
[Service]
User=root
Group=root
      HACK
      on hosts, 'mkdir -p /etc/systemd/system/munge.service.d'
      create_remote_file(hosts, '/etc/systemd/system/munge.service.d/hack.conf', service_hack)

      munge_yaml = <<-MUNGE
munge::manage_user: false
munge::user: root
munge::group: root
munge::lib_dir: /var/lib/munge
munge::log_dir: /var/log/munge
munge::conf_dir: /etc/munge
munge::run_dir: /run/munge
      MUNGE
      create_remote_file(hosts, '/etc/puppetlabs/puppet/data/munge.yaml', munge_yaml)
    end
  end
end
