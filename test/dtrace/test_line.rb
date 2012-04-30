require 'dtrace/helper'

module DTrace
  class TestLine < TestCase
    def test_line
      probe = "ruby#{$$}:::line { printf(\"%s %d\\n\", copyinstr(arg0), arg1); }"

      x = 2
      saw, line = trap_probe(probe) { 10.times { x = x ** 2 } }, __LINE__
      saw.map!(&:split)

      this = saw.find_all { |row| row.first == __FILE__ }

      assert_operator this.length, :>=, 10
      this.each { |f,l| assert_equal line.to_s, l }
    end
  end
end
