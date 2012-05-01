require 'minitest/autorun'
require 'tempfile'

module DTrace
  class TestCase < MiniTest::Unit::TestCase
    def setup
      skip "must be setuid 0 to run dtrace tests" unless Process.euid == 0
    end

    def trap_probe code
      f = Tempfile.new('omg.d')
      f.write code
      f.puts
      f.write 'tick-1hz { exit(0); }'
      f.flush
      probes = IO.popen("dtrace -q -s #{f.path}") do |io|
        sleep 0.5
        yield
        io.readlines.grep(/^\S+/)
      end
      f.close(true)
      probes
    end
  end
end
