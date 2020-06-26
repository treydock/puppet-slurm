# @api private
class slurm::slurmdbd::config {
  file { 'slurmdbd-ArchiveDir':
    ensure => 'directory',
    path   => $slurm::slurmdbd_archive_dir,
    owner  => $slurm::slurm_user,
    group  => $slurm::slurm_user_group,
    mode   => '0700',
  }

  if $slurm::slurmdbd_archive_dir_nfs_device {
    exec { 'mkdir-slurmdbd-ArchiveDir':
      path    => '/bin:/usr/bin',
      command => "mkdir -p ${slurm::slurmdbd_archive_dir}",
      creates => $slurm::slurmdbd_archive_dir,
      before  => Mount['slurmdbd-ArchiveDir'],
    }
    mount { 'slurmdbd-ArchiveDir':
      ensure  => 'mounted',
      name    => $slurm::slurmdbd_archive_dir,
      atboot  => true,
      device  => $slurm::slurmdbd_archive_dir_nfs_device,
      fstype  => 'nfs',
      options => $slurm::slurmdbd_archive_dir_nfs_options,
      before  => File['slurmdbd-ArchiveDir'],
    }
  }

  file { 'slurmdbd.conf':
    ensure  => 'file',
    path    => $slurm::slurmdbd_conf_path,
    owner   => $slurm::slurm_user,
    group   => $slurm::slurm_user_group,
    mode    => '0600',
    content => template('slurm/slurmdbd/slurmdbd.conf.erb'),
    notify  => $slurm::slurmdbd_notify,
  }
}
