# puppet-slurm

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/slurm.svg)](https://forge.puppetlabs.com/treydock/slurm)
[![CI Status](https://github.com/treydock/puppet-slurm/workflows/CI/badge.svg?branch=master)](https://github.com/treydock/puppet-slurm/actions?query=workflow%3ACI)

#### Table of Contents

1. [Overview](#overview)
    * [Supported Versions of SLURM](#supported-versions-of-slurm)
2. [Usage - Configuration options](#usage)
    * [Setup](#setup)
    * [Dependencies](#dependencies)
    * [Common](#common)
    * [Roles](#roles)
    * [Role: slurmdbd](#role-slurmdbd-and-database)
    * [Role: slurmctld](#role-slurmctld)
    * [Role: slurmd](#role-slurmd)
    * [Role: client](#role-client)
    * [Role: slurmrestd](#role-slurmrestd)
    * [slurm::conf usage](#slurmconf-usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

Manage SLURM.

### Supported Versions of SLURM

This module is designed to work with SLURM 25.05.x and 25.11.x.

| SLURM Version     | SLURM Puppet module versions |
| ----------------- | -----------------------------|
| 20.02.x           | 0.x                          |
| 20.11.x           | 1.x                          |
| 21.08.x & 22.05.x | 2.x                          |
| 23.02.x           | 3.x                          |
| 23.11.x           | 4.x                          |
| 23.11.x - 24.05.x | 5.x                          |
| 25.05.x - 25.11.x | 6.x                          |

## Usage

This module is designed so the majority of configuration changes are made through the `slurm` class directly.

In most cases all that is needed to begin using this module is to have `include slurm` defined. The following usage examples are all assuming that a host has `include slurm` performed already and the rest of the configuration is done via Hiera.

It's advisable to put as much of the Hiera data as possible in a location like `common.yaml`.

### Setup

In order to use SLURM the munge daemon must be configured. This module will include the `munge` class from [treydock/munge](https://forge.puppet.com/treydock/munge) but will not configure munge. The minimial configuration needed is to set the munge key source to the munge key stored in a module somewhere.

```yaml
munge::munge_key_source: "puppet:///modules/profile/munge.key"
```

As of version v2.3.0 you can also provide the content of the munge key, for example if your using EYAML in Hiera.

```
munge::munge_key_content: "supersecret"
```

### Dependencies

The following parameter changes can be made to avoid dependencies on several modules

* `slurm::manage_firewall: false` - Disable dependency on puppetlabs/firewall
* `slurm::use_nhc: false` OR `slurm::include_nhc: false` - Disable dependency on treydock/nhc
* `slurm::manage_rsyslog: false` OR `slurm::use_syslog: false` - Disable dependenchy on saz/rsyslog
* `slurm::manage_logrotate: false` - Disable dependency on puppet/logrotate
* `slurm::source_install_manage_alternatives: false` - When `install_method` is `source` and installing on a system without a default Python install, this will disable a dependency on puppet/alternatives
* `slurm::tuning_net_core_somaxconn: false` - Disable dependency on herculesteam/augeasproviders_sysctl

**NOTE**: If `use_syslog` is set to `true` there is a soft dependency on [saz/rsyslog](https://forge.puppet.com/saz/rsyslog)
**NOTE**: If `use_nhc` and `include_nhc` are set to `true` there is a soft dependency on [treydock/nhc](https://forge.puppet.com/treydock/nhc)

### common

The following could be included in `common.yaml`. This assumes your site has access to SLURM RPMs.

```yaml
slurm::repo_baseurl: "https://repo.hpc.osc.edu/internal/slurm/%{facts.os.release.major}/"
slurm::install_torque_wrapper: true
slurm::install_pam: true
slurm::slurm_group_gid: 93
slurm::slurm_user_uid: 93
slurm::slurm_user_home: /var/lib/slurm
slurm::manage_firewall: false
slurm::use_syslog: true
slurm::cluster_name: example
slurm::slurmctld_host:
  - slurmctld.example.com
slurm::slurmdbd_host: slurmdbd.example.com
slurm::greses:
  nvml:
    auto_detect: nvml
slurm::slurmd_spool_dir: /var/spool/slurmd
slurm::slurm_conf_override:
  AccountingStorageTRES:
    - gres/gpu
    - gres/gpu:tesla
    - license/ansys
  Licenses:
    - ansys:2
  ReturnToService: 2
  SelectType: select/cons_tres
  SelectTypeParameters:
    - CR_CPU
slurm::partitions:
  batch:
    default: 'YES'
    def_mem_per_cpu: 1700
    max_mem_per_cpu: 1750
    nodes: slurmd01
slurm::nodes:
  slurmd01:
    node_hostname: slurmd01.example.com
    cpus: 4
    threads_per_core: 1
    cores_per_socket: 1
    sockets: 4
    real_memory: 7000
```

### Roles

The behavior of this module is determined by 5 booleans that set the role for a host.

* `client` - When true will setup a host as SLURM client
* `slurmctld` - When true will setup a host to run slurmctld
* `slurmdbd` - When true will setup a host to run slurmdbd
* `database` - When true will setup a host to manage the slurmdbd MySQL database
* `slurmd` - When true will setup a host to run slurmd
* `slurmrestd` - When true will setup a host to run slurmrestd

**NOTE:** The only role enabled by default is `client`.

### Role: slurmdbd and database

The following example will setup an instance of slurmdbd that exports the database resource that can be collected by a database server:

```yaml
slurm::client: true
slurm::slurmdbd: true
slurm::database: true
slurm::slurmdbd_storage_host: db.example.com
slurm::slurmdbd_storage_loc: slurm_acct_db
slurm::slurmdbd_storage_user: slurmdbd
slurm::slurmdbd_storage_pass: changeme
slurm::export_database: true
slurm::export_database_tag: "%{lookup('slurm::slurmdbd_storage_host')}"
slurm::slurmdbd_conf_override:
  MaxQueryTimeRange: '90-00:00:00'
  MessageTimeout: '10'
```

The database server would have something like the following to collect the db resources

```puppet
Mysql::Db <<| tag == $facts['fqdn'] |>>
```

The following example would avoid PuppetDB dependency and require including the `slurm` class on the MySQL server

```yaml
# common.yaml
slurm::slurmdbd_storage_host: db.example.com
slurm::slurmdbd_storage_loc: slurm_acct_db
slurm::slurmdbd_storage_user: slurmdbd
slurm::slurmdbd_storage_pass: changeme
# fqdn/db.example.com.yaml
slurm::client: false
slurm::database: true
# fqdn/slurmdbd.example.com.yaml
slurm::slurmdbd: true
slurm::database: false
```

### Role: slurmctld

The following enables a host to act as the slurmctld daemon with a remote slurmdbd.

```yaml
slurm::client: true
slurm::slurmdbd: false
slurm::database: false
slurm::slurmctld: true
```

If you wish to enable configless SLURM:

```yaml
slurm::enable_configless: true
```

### Role: slurmd

The following enables a host to act as a slurmd compute node

```yaml
slurm::client: true
slurm::slurmdbd: false
slurm::database: false
slurm::slurmctld: false
slurm::slurmd: true
```

To have slurmd pull configs via configless SLURM:

```yaml
slurm::configless: true
```

### Role: client

If the majority of your configuration is done in `common.yaml` then the default for `slurm::client` of `true` is sufficient to configure a host to act as a SLURM client.

### Role: slurmrestd

First the common Hiera such as `common.yaml` should have something like the below. Setting `auth_alt_types` to include `auth/jwt` will activate the Puppet code to manage JWT resources where appropriate.

```yaml
slurm::auth_alt_types:
  - auth/jwt
slurm::jwt_key_source: 'puppet:///modules/site_slurm/jwt.key'
```

For the host to run slurmrestd:

```yaml
slurm::slurmrestd: true
```

### slurm::conf usage

It's possible to deploy multiple slurm.conf files using this module.

The following example will deploy `/etc/slurm/slurm-ascend.conf` with only ClusterName and SlurmctldHost changed.

```puppet
include slurm
$cluster_conf = {
  'ClusterName'   => 'ascend',
  'SlurmctldHost' => 'ascend-slurm01.example.com',
}
slurm::conf { 'ascend':
  configs => $slurm::slurm_conf + $cluster_conf,
}
```

## Reference

[http://treydock.github.io/puppet-slurm/](http://treydock.github.io/puppet-slurm/)

## Limitations

This module has been tested on:

* RedHat/Rocky/AlmaLinux 8 x86_64
* RedHat/Rocky/AlmaLinux 9 x86_64
* Debian 11 x86_64
* Debian 12 x86_64
* Ubuntu 22.04 x86_64
* Ubuntu 24.04 x86_64
