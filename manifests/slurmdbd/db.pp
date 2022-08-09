# @api private
class slurm::slurmdbd::db {
  if $slurm::manage_database {
    if $facts['os']['release']['major'] == '20.04' {
      $charset = 'utf8mb3'
      $collate = 'utf8mb3_general_ci'
    } else {
      $charset = 'utf8'
      $collate = 'utf8_general_ci'
    }
    if $slurm::export_database {
      @@mysql::db { "slurmdbd_${::fqdn}":
        user     => $slurm::slurmdbd_storage_user,
        password => $slurm::slurmdbd_storage_pass,
        dbname   => $slurm::slurmdbd_storage_loc,
        host     => $::fqdn,
        grant    => ['ALL'],
        charset  => $charset,
        collate  => $collate,
        tag      => $slurm::export_database_tag,
      }
    } else {
      mysql::db { $slurm::slurmdbd_storage_loc:
        user     => $slurm::slurmdbd_storage_user,
        password => $slurm::slurmdbd_storage_pass,
        host     => $slurm::slurmdbd_storage_host,
        grant    => ['ALL'],
        charset  => $charset,
        collate  => $collate,
      }
    }
  }
}
