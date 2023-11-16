# @api private
class slurm::common::install {
  if $slurm::osfamily == 'RedHat' {
    $package_class = 'slurm::common::install::rpm'
  } elsif $slurm::osfamily == 'Debian' {
    $package_class = 'slurm::common::install::apt'
  }

  if $slurm::repo_baseurl {
    $install_method = pick($slurm::install_method, 'package')
  } else {
    $install_method = pick($slurm::install_method, 'source')
  }
  if $install_method == 'package' {
    $install_class = $package_class
  } elsif $install_method == 'source' {
    $install_class = 'slurm::common::install::source'
  }

  if $install_method != 'none' {
    contain $install_class
  }
}
