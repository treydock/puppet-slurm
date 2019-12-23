# slurmdbd_version.rb

Facter.add(:slurmdbd_version) do
  confine kernel: :linux

  setcode do
    value = nil
    slurmdbd = Facter::Util::Resolution.which('slurmdbd')
    if slurmdbd
      output = Facter::Util::Resolution.exec("#{slurmdbd} -V 2>/dev/null")
      unless output.nil?
        value = output[%r{^slurm (.*)$}, 1]
      end
    end
    value
  end
end
