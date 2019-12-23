# slurmctld_version.rb

Facter.add(:slurmctld_version) do
  confine kernel: :linux

  setcode do
    value = nil
    slurmctld = Facter::Util::Resolution.which('slurmctld')
    if slurmctld
      output = Facter::Util::Resolution.exec("#{slurmctld} -V 2>/dev/null")
      unless output.nil?
        value = output[%r{^slurm (.*)$}, 1]
      end
    end
    value
  end
end
