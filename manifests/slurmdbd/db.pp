# @api private
class slurm::slurmdbd::db {
  if $slurm::manage_database {
    if $slurm::export_database {
      @@mysql::db { "slurmdbd_${facts['networking']['fqdn']}":
        user     => $slurm::slurmdbd_storage_user,
        password => $slurm::slurmdbd_storage_pass,
        dbname   => $slurm::slurmdbd_storage_loc,
        host     => $facts['networking']['fqdn'],
        grant    => ['ALL'],
        charset  => $slurm::slurmdbd_db_charset,
        collate  => $slurm::slurmdbd_db_collate,
        tag      => $slurm::export_database_tag,
      }
    } else {
      mysql::db { $slurm::slurmdbd_storage_loc:
        user     => $slurm::slurmdbd_storage_user,
        password => $slurm::slurmdbd_storage_pass,
        host     => $slurm::slurmdbd_storage_host,
        grant    => ['ALL'],
        charset  => $slurm::slurmdbd_db_charset,
        collate  => $slurm::slurmdbd_db_collate,
      }
    }
  }
}
