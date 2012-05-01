require 'dtrace/helper'

module DTrace
  class TestLine < TestCase
    def test_line
      probe = "ruby$target:::line { printf(\"%s %d\\n\", copyinstr(arg0), arg1); }"
      program = 'x = 2; 10.times { x = x ** 2 }'

      trap_probe(probe, program) { |_, rbpath, saw|
	saw = saw.map(&:split).find_all { |file, _|
	  file == rbpath
	}
	assert_operator saw.length, :>=, 10
	saw.each { |f,l| assert_equal '1', l }
      }
    end
  end
end
