# puppet-slurm

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/slurm.svg)](https://forge.puppetlabs.com/treydock/slurm)
[![Build Status](https://travis-ci.org/treydock/puppet-slurm.svg?branch=master)](https://travis-ci.org/treydock/puppet-slurm)

#### Table of Contents

1. [Overview](#overview)
    * [Supported Versions of SLURM](#supported-versions-of-slurm)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

Manage SLURM.

### Supported Versions of SLURM

This module is designed to work with SLURM 19.05.3.

## Usage

## Reference

[http://treydock.github.io/puppet-slurm/](http://treydock.github.io/puppet-slurm/)

## Limitations

This module has been tested on:

* RedHat/CentOS 7 x86_64

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake spec

The following environment variables can be used to modify the behavior of the beaker tests:

* *SLURM\_BEAKER\_repo\_baseurl* - URL to Yum repository containing SLURM RPMs. If not present will install from source
* *SLURM\_BEAKER\\_version* - Version of SLURM to install.  Defaults to **19.05.4**

Example of running beaker tests using an internal repository, and leaving VMs running after the tests.

    export BEAKER_destroy=no
    export BEAKER_PUPPET_COLLECTION=puppet5
    export PUPPET_INSTALL_TYPE=agent
    export BEAKER_set=centos-7
    export SLURM_BEAKER_repo_baseurl="http://yum.example.com/slurm/el/7/x86_64"
    bundle exec rake beaker
