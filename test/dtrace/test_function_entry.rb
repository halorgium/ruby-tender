require 'dtrace/helper'

module DTrace
  class TestFunctionEntry < TestCase
    def test_function_entry
      probe = <<-eoprobe
ruby$target:::function-entry
{
  printf("%s %s %s %d\\n", copyinstr(arg0), copyinstr(arg1), copyinstr(arg2), arg3);
}
      eoprobe

      trap_probe(probe, ruby_program) { |d_file, rb_file, probes|
	foo_calls = probes.map { |line| line.split }.find_all { |row|
	  row.first == 'Foo'  && row[1] == 'foo'
	}

	assert_equal 10, foo_calls.length
	line = '2'
	foo_calls.each { |f| assert_equal line, f[3] }
	foo_calls.each { |f| assert_equal rb_file, f[2] }
      }
    end

    def test_function_return
      probe = <<-eoprobe
ruby$target:::function-return
{
  printf("%s %s %s %d\\n", copyinstr(arg0), copyinstr(arg1), copyinstr(arg2), arg3);
}
      eoprobe

      trap_probe(probe, ruby_program) { |d_file, rb_file, probes|
	foo_calls = probes.map { |line| line.split }.find_all { |row|
	  row.first == 'Foo'  && row[1] == 'foo'
	}

	assert_equal 10, foo_calls.length
	line = '2'
	foo_calls.each { |f| assert_equal line, f[3] }
	foo_calls.each { |f| assert_equal rb_file, f[2] }
      }
    end

    private
    def ruby_program
      <<-eoruby
      class Foo
	def foo; end
      end
      x = Foo.new
      10.times { x.foo }
      eoruby
    end
  end
end
