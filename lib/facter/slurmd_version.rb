# frozen_string_literal: true

# slurmd_version.rb

Facter.add(:slurmd_version) do
  confine kernel: :linux

  setcode do
    value = nil
    slurmd = Facter::Core::Execution.which('slurmd')
    if slurmd
      output = Facter::Core::Execution.execute("timeout 2 #{slurmd} -V 2>/dev/null")
      unless output.nil?
        value = output[%r{^slurm (.*)$}, 1]
      end
    end
    value
  end
end
