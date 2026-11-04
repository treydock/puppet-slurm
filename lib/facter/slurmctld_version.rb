# frozen_string_literal: true

# slurmctld_version.rb

Facter.add(:slurmctld_version) do
  confine kernel: :linux

  setcode do
    value = nil
    slurmctld = Facter::Core::Execution.which('slurmctld')
    if slurmctld
      output = Facter::Core::Execution.execute("timeout 2 #{slurmctld} -V 2>/dev/null")
      unless output.nil?
        value = output[%r{^slurm (.*)$}, 1]
      end
    end
    value
  end
end
