require 'dtrace/helper'

module DTrace
  class TestFunctionEntry < TestCase
    def foo
    end

    def test_function_entry
      probe = <<-eoprobe
ruby#{$$}:::function-entry
{
  printf("%s %s %s %d\\n", copyinstr(arg0), copyinstr(arg1), copyinstr(arg2), arg3);
}
      eoprobe
      saw = trap_probe(probe) { 10.times { foo } }
      foo_calls = saw.map { |line| line.split }.find_all { |row|
	row.first == self.class.name && row[1] == 'foo'
      }

      assert_equal 10, foo_calls.length
      line = method(:foo).source_location[1].to_s
      foo_calls.each { |f| assert_equal line, f[3] }
      foo_calls.each { |f| assert_equal __FILE__, f[2] }
    end
  end
end
