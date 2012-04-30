require 'dtrace/helper'

module DTrace
  class TestLoad < TestCase
    def test_load_entry
      probe = <<-eoprobe
ruby#{$$}:::raise
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw, line = trap_probe(probe) { 10.times { raise rescue nil } }, __LINE__
      assert_equal 10, saw.length
      saw.map { |s| s.split }.each do |(klass, source_file, source_line)|
	assert_equal 'RuntimeError', klass
	assert_equal __FILE__, source_file
	assert_equal line.to_s, source_line
      end
    end
  end
end
