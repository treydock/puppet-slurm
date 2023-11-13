#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true

require 'json'
require 'open3'

# SlurmReconfig class
class SlurmReconfig
  def self.execute(scontrol)
    cmd = "#{scontrol} reconfig"
    stdout, stderr, status = Open3.capture3(cmd)
    if status != 0
      raise StandardError, "Failed to execute #{cmd}: #{stdout + stderr}"
    end

    { out: stdout, err: stderr, exit: status }
  end

  def self.run
    params = JSON.parse($stdin.read)
    scontrol = params['scontrol'] || 'scontrol'

    result = execute(scontrol)

    puts(result.to_json)
  rescue Exception => e # rubocop:disable Lint/RescueException
    puts({ _error: e.message }.to_json)
    exit 1
  end
end

SlurmReconfig.run if $PROGRAM_NAME == __FILE__
