# @api private
class slurm::common::munge {
  if $slurm::manage_munge {
    class { 'munge':
      munge_key_source  => $slurm::munge_key_source,
      munge_key_content => $slurm::munge_key_content,
    }
  } else {
    include munge
  }
}
