# frozen_string_literal: true

# slurm_version.rb

Facter.add(:slurm_version) do
  confine kernel: :linux

  setcode do
    value = {}
    sinfo = Facter::Core::Execution.which('sinfo')
    if sinfo
      output = Facter::Core::Execution.execute("timeout 2 #{sinfo} -V 2>/dev/null")
      if output =~ %r{^slurm}
        full = output[%r{^slurm (.*)$}, 1]
        major = full.split('.')[0, 2].join('.')
        value = {
          full: full,
          major: major,
        }
      end
    end
    value
  end
end
