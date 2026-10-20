# @api private
class slurm::common::config {
  create_resources('slurm::spank', $slurm::spank_plugins)

  if $slurm::manage_slurm_conf and ! $slurm::configless {
    slurm::conf { 'slurm.conf':
      configs     => $slurm::slurm_conf,
      template    => $slurm::slurm_conf_template,
      source      => $slurm::slurm_conf_source,
      config_name => 'slurm.conf',
    }

    if $slurm::partition_source {
      concat::fragment { 'slurm.conf-partition-source':
        target => 'slurm.conf',
        source => $slurm::partition_source,
        order  => '25',
      }
    }
    $slurm::partitions.each |$name, $partition| {
      slurm::partition { $name: * => $partition }
    }

    if $slurm::node_source {
      concat::fragment { 'slurm.conf-node-source':
        target => 'slurm.conf',
        source => $slurm::node_source,
        order  => '75',
      }
    }
    $slurm::nodes.each |$name, $_node| {
      slurm::node { $name: * => $_node }
    }
    $slurm::nodesets.each |$name, $_nodeset| {
      slurm::nodeset { $name: * => $_nodeset }
    }

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
    $slurm::switches.each |$name, $switch| {
      slurm::switch { $name: * => $switch }
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
      $slurm::greses.each |$name, $gres| {
        slurm::gres { $name: * => $gres }
      }

      if empty($slurm::job_containers) {
        $job_container_ensure = 'absent'
      } else {
        $job_container_ensure = 'file'
      }
      # TODO: Remove this file once 25.05 not supported
      concat { 'job_container.conf':
        ensure => $job_container_ensure,
        path   => $slurm::job_container_conf_path,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        notify => $slurm::service_notify,
      }
      concat::fragment { 'job_container.conf-header':
        target  => 'job_container.conf',
        content => "# File managed by Puppet - DO NOT EDIT\n",
        order   => '00',
      }
      $slurm::job_containers.each |$name, $job_container| {
        slurm::job_container { $name: * => $job_container }
      }

      if empty($slurm::namespace_defaults) {
        $namespace_data = undef
      } else {
        if $slurm::namespace_defaults['dirs'] =~ Array {
          $default_dirs = $slurm::namespace_defaults['dirs'].join(',')
        } else {
          $default_dirs = $slurm::namespace_defaults['dirs']
        }
        $namespace_defaults = $slurm::namespace_defaults + {
          'dirs' => $default_dirs,
        }
        $namespace_data = {
          'defaults' => $namespace_defaults,
          'disable_bpf_token' => $slurm::namespace_disable_bpf_token,
        }.filter |$k,$v| { $v =~ NotUndef }
      }
      if $namespace_data =~ Undef and empty($slurm::namespace_node_confs) {
        $namespace_ensure = 'absent'
      } else {
        $namespace_ensure = 'file'
      }
      collections::file { $slurm::namespace_conf_path:
        collector => 'namespace',
        template  => 'collections/yaml.epp',
        file      => {
          ensure => $namespace_ensure,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
        },
        data      => $namespace_data,
      }
      $slurm::namespace_node_confs.each |$name, $node_conf| {
        if 'options' in $node_conf {
          if $node_conf['options']['dirs'] =~ Array {
            $dirs = $node_conf['options']['dirs'].join(',')
          } else {
            $dirs = $node_conf['options']['dirs']
          }
          $options = $node_conf['options'] + {
            'dirs' => $dirs,
          }
        } else {
          $options = undef
        }
        slurm::namespace::node_conf { $name:
          options => $options,
          *       => $node_conf - ['options'],
        }
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

    file { 'slurm-oci.conf':
      ensure  => 'file',
      path    => $slurm::oci_conf_path,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $slurm::oci_conf_content,
      source  => $slurm::oci_conf_source,
      notify  => $slurm::service_notify,
    }

    if $slurm::cli_filter_lua_source or $slurm::cli_filter_lua_content {
      file { "${slurm::conf_dir}/cli_filter.lua":
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => $slurm::cli_filter_lua_source,
        content => $slurm::cli_filter_lua_content,
      }

      if $slurm::slurmctld and $slurm::enable_configless {
        File["${slurm::conf_dir}/cli_filter.lua"] ~> Exec['scontrol reconfig']
      }
    }

    if $slurm::scrun_lua_source or $slurm::scrun_lua_content {
      file { "${slurm::conf_dir}/scrun.lua":
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => $slurm::scrun_lua_source,
        content => $slurm::scrun_lua_content,
      }

      if $slurm::slurmctld and $slurm::enable_configless {
        File["${slurm::conf_dir}/scrun.lua"] ~> Exec['scontrol reconfig']
      }
    }
  }

  if ('auth/jwt' in $slurm::auth_alt_types) and ($slurm::slurmctld or $slurm::slurmdbd) {
    file { $slurm::jwt_key_path:
      ensure  => 'file',
      owner   => $slurm::slurm_user,
      group   => $slurm::slurm_user,
      mode    => '0600',
      content => $slurm::jwt_key_content,
      source  => $slurm::jwt_key_source,
    }
    if $slurm::jwks_url {
      exec { 'get-jwks.json':
        path    => '/usr/bin:/bin:/usr/sbin:/sbin',
        command => "curl -sSf -o ${slurm::jwks_json_path} ${slurm::jwks_url}",
        creates => $slurm::jwks_json_path,
      }
      file { $slurm::jwks_json_path:
        ensure  => 'file',
        owner   => $slurm::slurm_user,
        group   => $slurm::slurm_user,
        mode    => '0600',
        require => Exec['get-jwks.json'],
      }
    }
  }

  if $slurm::tuning_net_core_somaxconn {
    sysctl { 'net.core.somaxconn':
      ensure => 'present',
      value  => String($slurm::tuning_net_core_somaxconn),
    }
  }
}
