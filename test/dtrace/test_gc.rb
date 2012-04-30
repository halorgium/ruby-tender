require 'dtrace/helper'

module DTrace
  class TestGC < TestCase
    %w{
      gc-begin
      gc-end
      gc-mark-begin
      gc-mark-end
      gc-sweep-begin
      gc-sweep-end
    }.each do |probe_name|
      define_method(:"test_#{probe_name.gsub(/-/, '_')}") do
	probe = "ruby#{$$}:::#{probe_name} { printf(\"#{probe_name}\\n\"); }"

	saw = trap_probe(probe) {
	  100000.times { Object.new }
	  GC.start
	}

	assert_operator saw.length, :>, 0
      end
    end
  end
end
