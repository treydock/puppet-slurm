# frozen_string_literal: true

# slurmctld_nodes.rb

Facter.add(:slurm_nodes) do
  confine kernel: :linux

  setcode do
    value = nil
    slurmctld = Facter::Util::Resolution.which('slurmctld')
    sinfo = Facter::Util::Resolution.which('sinfo')
    if slurmctld && sinfo
      output = Facter::Util::Resolution.exec("timeout 5 #{sinfo} -a -h -N -o '%N' 2>/dev/null")
      unless output.nil?
        value = output.lines.map(&:strip).sort.uniq
      end
    end
    value
  end
end
