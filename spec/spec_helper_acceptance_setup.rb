RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  c.add_setting :slurm_repo_baseurl
  c.slurm_repo_baseurl = ENV['SLURM_BEAKER_repo_baseurl'] || nil

  c.add_setting :slurm_version
  c.slurm_version = ENV['SLURM_BEAKER_version'] || '20.11.8'

  if ENV['BEAKER_set'] =~ %r{cluster}
    slurmctld_host = 'slurmctld'
    slurmdbd_host = 'slurmdbd'
  else
    slurmctld_host = 'slurm'
    slurmdbd_host = 'slurm'
  end

  slurmd_ip = find_only_one(:slurmd).ip
  on hosts, puppet('resource', 'host', 'slurmd', "ip=#{slurmd_ip}")

  install_method_hiera = if RSpec.configuration.slurm_repo_baseurl.nil?
                           'slurm::install_method: source'
                         else
                           "slurm::repo_baseurl: '#{RSpec.configuration.slurm_repo_baseurl}'"
                         end

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    copy_module_to(hosts, source: File.join(proj_root, 'spec/fixtures/site_slurm'), module_name: 'site_slurm', ignore_list: [])

    # Add soft dependencies
    on hosts, puppet('module', 'install', 'treydock-nhc'), acceptable_exit_codes: [0, 1]
    on hosts, puppet('module', 'install', 'saz-rsyslog'), acceptable_exit_codes: [0, 1]

    hiera_yaml = <<-EOS
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: virtual
    path: "%{facts.virtual}.yaml"
  - name: "Munge"
    path: "munge.yaml"
  - name: "common"
    path: "common.yaml"
EOS
    common_yaml = <<-EOS
munge::munge_key_source: 'puppet:///modules/site_slurm/munge.key'
#{install_method_hiera}
slurm::version: '#{RSpec.configuration.slurm_version}'
slurm::slurmctld_host: '#{slurmctld_host}'
slurm::slurmdbd_host: '#{slurmdbd_host}'
slurm::slurmd_options: '-N slurmd'
slurm::partitions:
  general:
    default: 'YES'
    nodes: 'slurmd'
slurm::nodes:
  slurmd:
    cpus: 1
EOS
    docker_yaml = <<-EOS
slurm::manage_firewall: false
slurm::slurm_conf_override:
  JobAcctGatherType: 'jobacct_gather/linux'
  ProctrackType: 'proctrack/linuxproc'
  TaskPlugin: 'task/affinity'
slurm::manage_slurm_user: false
slurm::slurm_user: root
slurm::slurm_user_group: root
EOS
    create_remote_file(hosts, '/etc/puppetlabs/puppet/hiera.yaml', hiera_yaml)
    on hosts, 'mkdir -p /etc/puppetlabs/puppet/data'
    create_remote_file(hosts, '/etc/puppetlabs/puppet/data/common.yaml', common_yaml)
    create_remote_file(hosts, '/etc/puppetlabs/puppet/data/docker.yaml', docker_yaml)
    # 'hyperv' is reported by Github Actions
    create_remote_file(hosts, '/etc/puppetlabs/puppet/data/hyperv.yaml', docker_yaml)

    # Hack to work around issues with recent systemd and docker and running services as non-root
    if fact('os.family') == 'RedHat' && fact('os.release.major').to_i >= 7
      service_hack = <<-EOS
[Service]
User=root
Group=root
    EOS

      on hosts, 'mkdir -p /etc/systemd/system/munge.service.d'
      create_remote_file(hosts, '/etc/systemd/system/munge.service.d/hack.conf', service_hack)

      munge_yaml = <<-EOS
---
munge::manage_user: false
munge::user: root
munge::group: root
munge::lib_dir: /var/lib/munge
munge::log_dir: /var/log/munge
munge::conf_dir: /etc/munge
munge::run_dir: /run/munge
    EOS

      create_remote_file(hosts, '/etc/puppetlabs/puppet/data/munge.yaml', munge_yaml)
    end
  end
end
