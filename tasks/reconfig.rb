#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
require 'open3'

class SlurmReconfig
  def self.execute(scontrol)
    cmd = "#{scontrol} reconfig"
    stdout, stderr, status = Open3.capture3(cmd)
    if status != 0
      raise Exception, "Failed to execute #{cmd}: #{stdout + stderr}"
    end
    result = {out: stdout, err: stderr, exit: status}
    return result
  end

  def self.run
    params = JSON.parse(STDIN.read)
    scontrol = params['scontrol'] || 'scontrol'

    result = execute(scontrol)

    puts(result.to_json)

  rescue Exception => e
    puts({ _error: e.message }.to_json)
    exit 1
  end
end

SlurmReconfig.run if $PROGRAM_NAME == __FILE__
