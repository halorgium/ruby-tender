require 'dtrace/helper'
require 'tempfile'

module DTrace
  class TestLoad < TestCase
    def setup
      @rbfile = Tempfile.new(['omg', 'rb'])
      @rbfile.write 'x = 10'
    end

    def teardown
      @rbfile.close(true)
    end

    def test_load_entry
      probe = <<-eoprobe
ruby#{$$}:::load-entry
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw, line = trap_probe(probe) { 10.times { load @rbfile.path } }, __LINE__
      assert_equal 10, saw.length
      saw.map { |s| s.split }.each do |(required, _)|
	assert_equal @rbfile.path, required
      end
    end

    def test_require_return
      probe = <<-eoprobe
ruby#{$$}:::load-return
{
  printf("%s\\n", copyinstr(arg0));
}
      eoprobe
      saw, line = trap_probe(probe) { 10.times { load @rbfile.path } }, __LINE__
      assert_equal 10, saw.length
      saw.each do |required|
	assert_equal @rbfile.path, required.chomp
      end
    end
  end
end

