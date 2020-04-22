# @api private
class slurm::common::config {

  create_resources('slurm::spank', $slurm::spank_plugins)

  if $slurm::manage_slurm_conf and ! $slurm::configless {
    concat { 'slurm.conf':
      ensure => 'present',
      path   => $slurm::slurm_conf_path,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      notify => $slurm::service_notify,
    }

    concat::fragment { 'slurm.conf-config':
      target  => 'slurm.conf',
      content => $slurm::slurm_conf_content,
      source  => $slurm::slurm_conf_source,
      order   => '00',
    }

    if $slurm::partition_source {
      concat::fragment { 'slurm.conf-partition-source':
        target => 'slurm.conf',
        source => $slurm::partition_source,
        order  => '25',
      }
    }
    $::slurm::partitions.each |$name, $partition| {
      slurm::partition { $name: * => $partition }
    }

    if $slurm::node_source {
      concat::fragment { 'slurm.conf-node-source':
        target => 'slurm.conf',
        source => $slurm::node_source,
        order  => '75',
      }
    }
    $::slurm::nodes.each |$name, $_node| {
      slurm::node { $name: * => $_node }
    }

    if $slurm::slurmd or $slurm::slurmctld {
      concat { 'slurm-topology.conf':
        ensure => 'present',
        path   => $slurm::topology_conf_path,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify => $slurm::service_notify,
      }
      concat::fragment { 'slurm-topology.conf-header':
        target  => 'slurm-topology.conf',
        content => "# File managed by Puppet - DO NOT EDIT\n",
        order   => '00',
      }
      if $slurm::topology_source {
        concat::fragment { 'slurm-topology.conf-source':
          target => 'slurm-topology.conf',
          source => $slurm::topology_source,
          order  => '01',
        }
      }
      $::slurm::switches.each |$name, $switch| {
        slurm::switch { $name: * => $switch }
      }
    }

    if $slurm::slurmd or $slurm::slurmctld {
      concat { 'slurm-gres.conf':
        ensure => 'present',
        path   => $slurm::gres_conf_path,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify => $slurm::service_notify,
      }
      concat::fragment { 'slurm-gres.conf-header':
        target  => 'slurm-gres.conf',
        content => "# File managed by Puppet - DO NOT EDIT\n",
        order   => '00',
      }
      if $slurm::gres_source {
        concat::fragment { 'slurm-gres.conf-source':
          target => 'slurm-gres.conf',
          source => $slurm::gres_source,
          order  => '01',
        }
      }
      $::slurm::greses.each |$name, $gres| {
        slurm::gres { $name: * => $gres }
      }
    }

    concat { 'plugstack.conf':
      ensure => 'present',
      path   => $slurm::plugstack_conf_path,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      notify => $slurm::service_notify,
    }
    concat::fragment { 'plugstack.conf-header':
      target  => 'plugstack.conf',
      content => "# File managed by Puppet - DO NOT EDIT\n",
      order   => '00',
    }

    file { 'slurm-cgroup.conf':
      ensure  => 'file',
      path    => $slurm::cgroup_conf_path,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $slurm::cgroup_conf_content,
      source  => $slurm::cgroup_conf_source,
      notify  => $slurm::service_notify,
    }
  }

  if $slurm::tuning_net_core_somaxconn {
    sysctl { 'net.core.somaxconn':
      ensure => 'present',
      value  => String($slurm::tuning_net_core_somaxconn),
    }
  }
}
