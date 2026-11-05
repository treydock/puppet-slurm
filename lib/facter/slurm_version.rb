# frozen_string_literal: true

# slurm_version.rb

Facter.add(:slurm_version) do
  confine kernel: :linux

  setcode do
    value = nil
    full = nil
    package_cmd = nil
    if Facter.value('os.family') == 'RedHat'
      package_cmd = "rpm -q slurm --qf '%{NAME}-%{VERSION}' 2>/dev/null"
    end
    if Facter.value('os.family') == 'Debian'
      package_cmd = "dpkg-query --showformat='${Package}-${Version}' --show slurm 2>/dev/null"
    end
    unless package_cmd.nil?
      version = Facter::Core::Execution.execute(package_cmd)
      if version =~ %r{^slurm-.+}
        full = version[%r{^slurm-(.*)}, 1]
      end
    end
    sinfo = Facter::Core::Execution.which('sinfo')
    if sinfo && full.nil?
      output = Facter::Core::Execution.execute("timeout 2 #{sinfo} -V 2>/dev/null")
      if output =~ %r{^slurm}
        full = output[%r{^slurm (.*)$}, 1]
      end
    end
    unless full.nil?
      major = full.split('.')[0, 2].join('.')
      value = {
        full: full,
        major: major,
      }
    end
    value
  end
end
