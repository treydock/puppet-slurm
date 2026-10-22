# frozen_string_literal: true

# slurmctld_nodes.rb

Facter.add(:slurm_nodes) do
  confine kernel: :linux

  setcode do
    value = nil
    slurmctld = Facter::Core::Execution.which('slurmctld')
    sinfo = Facter::Core::Execution.which('sinfo')
    if slurmctld && sinfo
      output = Facter::Core::Execution.execute("timeout 5 #{sinfo} -a -h -N -o '%N' 2>/dev/null")
      unless output.nil?
        value = output.lines.map(&:strip).sort.uniq
      end
    end
    value
  end
end
