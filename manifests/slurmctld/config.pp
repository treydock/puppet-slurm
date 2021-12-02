# @api private
class slurm::slurmctld::config {
  file { 'StateSaveLocation':
    ensure => 'directory',
    path   => $slurm::state_save_location,
    owner  => $slurm::slurm_user,
    group  => $slurm::slurm_user_group,
    mode   => '0700',
  }

  if $slurm::state_dir_nfs_device {
    exec { 'mkdir-StateSaveLocation':
      path    => '/bin:/usr/bin',
      command => "mkdir -p ${slurm::state_save_location}",
      creates => $slurm::state_save_location,
      before  => Mount['StateSaveLocation'],
    }
    mount { 'StateSaveLocation':
      ensure  => 'mounted',
      name    => $slurm::state_save_location,
      atboot  => true,
      device  => $slurm::state_dir_nfs_device,
      fstype  => 'nfs',
      options => $slurm::state_dir_nfs_options,
      before  => File['StateSaveLocation'],
    }
  }

  if $slurm::job_submit_lua_source or $slurm::job_submit_lua_content {
    file { "${slurm::conf_dir}/job_submit.lua":
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => $slurm::job_submit_lua_source,
      content => $slurm::job_submit_lua_content,
    }
  }

  if $slurm::slurm_conf['AuthAltTypes'] and $slurm::slurm_conf['AuthAltTypes'] == 'auth/jwt' {
    $jwt_key = "${slurm::state_save_location}/jwt_hs256.key"
    exec { 'slurmctld-genrsa':
      path    => '/usr/bin:/bin:/usr/sbin:/sbin',
      command => "openssl genrsa -out ${jwt_key} 2048",
      creates => $jwt_key,
    }
    -> file { $jwt_key:
      owner => $slurm::slurm_user,
      group => 'root',
      mode  => '0640',
    }
  }
}
