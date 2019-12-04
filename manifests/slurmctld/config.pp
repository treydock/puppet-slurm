# @api private
class slurm::slurmctld::config {
  file { 'StateSaveLocation':
    ensure => 'directory',
    path   => $slurm::state_save_location,
    owner  => $slurm::slurm_user,
    group  => $slurm::slurm_user_group,
    mode   => '0700',
  }

  file { 'JobCheckpointDir':
    ensure => 'directory',
    path   => $slurm::job_checkpoint_dir,
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

  if $slurm::job_checkpoint_dir_nfs_device {
    exec { 'mkdir-JobCheckpointDir':
      path    => '/bin:/usr/bin',
      command => "mkdir -p ${slurm::job_checkpoint_dir}",
      creates => $slurm::job_checkpoint_dir,
      before  => Mount['JobCheckpointDir'],
    }
    mount { 'JobCheckpointDir':
      ensure  => 'mounted',
      name    => $slurm::job_checkpoint_dir,
      atboot  => true,
      device  => $slurm::job_checkpoint_dir_nfs_device,
      fstype  => 'nfs',
      options => $slurm::job_checkpoint_dir_nfs_options,
      before  => File['JobCheckpointDir'],
    }
  }
}
