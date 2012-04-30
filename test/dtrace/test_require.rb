require 'dtrace/helper'

module DTrace
  class TestRequire < TestCase
    def test_require_entry
      probe = <<-eoprobe
ruby#{$$}:::require-entry
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw, line = trap_probe(probe) { 10.times { require 'dtrace/helper' } }, __LINE__
      assert_equal 10, saw.length
      saw.map { |s| s.split }.each do |(required, _)|
	assert_equal 'dtrace/helper', required
      end
    end

    def test_require_return
      probe = <<-eoprobe
ruby#{$$}:::require-return
{
  printf("%s\\n", copyinstr(arg0));
}
      eoprobe
      saw, line = trap_probe(probe) { 10.times { require 'dtrace/helper' } }, __LINE__
      assert_equal 10, saw.length
      saw.map { |s| s.split }.each do |(required, _)|
	assert_equal 'dtrace/helper', required
      end
    end
  end
end
