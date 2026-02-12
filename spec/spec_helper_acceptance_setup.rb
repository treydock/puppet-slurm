# frozen_string_literal: true

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  c.add_setting :slurm_repo_baseurl
  c.slurm_repo_baseurl = ENV['SLURM_BEAKER_repo_baseurl'] || nil

  c.add_setting :slurm_version
  c.slurm_version = ENV['BEAKER_slurm_version'] || '23.11.5'

  if ENV['BEAKER_set'] =~ %r{cluster}
    slurmctld_host = 'slurmctld'
    slurmdbd_host = 'slurmdbd'
  else
    slurmctld_host = 'slurm'
    slurmdbd_host = 'slurm'
  end

  install_method_hiera = if RSpec.configuration.slurm_repo_baseurl.nil?
                           'slurm::install_method: source'
                         else
                           "slurm::repo_baseurl: '#{RSpec.configuration.slurm_repo_baseurl}'"
                         end

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    copy_module_to(hosts, source: File.join(proj_root, 'spec/fixtures/site_slurm'), module_name: 'site_slurm', ignore_list: [])

    # Dependencies for acceptance
    on hosts, puppet('module', 'install', 'puppetlabs-host_core', '--version=">=1.0.0 <3.0.0"')
    # Dependencies for NHC
    on hosts, puppet('module', 'install', 'puppetlabs-vcsrepo', '--version=">=6.0.0 <8.0.0"')
    on hosts, puppet('module', 'install', 'puppet-yum', '--version=">=6.0.0 <8.0.0"')
    # Add soft dependencies
    on hosts, puppet('module', 'install', 'treydock-nhc', '--version=7.0.0')
    on hosts, puppet('module', 'install', 'saz-rsyslog')

    slurmd_ip = find_only_one(:slurmd).ip
    on hosts, puppet('resource', 'host', 'slurmd', 'ensure=absent')
    on hosts, puppet('resource', 'host', 'slurmd', "ip=#{slurmd_ip}", 'host_aliases=slurm')

    puppet_dir = if fact('os.name') == 'Debian' && fact('os.release.major').to_i >= 12
                   '/etc/puppet'
                 elsif fact('os.name') == 'Ubuntu' && fact('os.release.major').to_s.split('.')[0].to_i >= 24
                   '/etc/puppet'
                 else
                   '/etc/puppetlabs/puppet'
                 end

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
    create_remote_file(hosts, File.join(puppet_dir, 'hiera.yaml'), hiera_yaml)
    on hosts, "mkdir -p #{File.join(puppet_dir, 'data')}"
    create_remote_file(hosts, File.join(puppet_dir, 'data/common.yaml'), common_yaml)
    # For some reason /etc ends up with wrong permissions.
    on hosts, 'chmod 0755 /etc'
  end
end
