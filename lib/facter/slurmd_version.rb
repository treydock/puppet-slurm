# slurmd_version.rb

Facter.add(:slurmd_version) do
  confine kernel: :linux

  setcode do
    value = nil
    slurmd = Facter::Util::Resolution.which('slurmd')
    if slurmd
      output = Facter::Util::Resolution.exec("#{slurmd} -V 2>/dev/null")
      unless output.nil?
        value = output[%r{^slurm (.*)$}, 1]
      end
    end
    value
  end
end
