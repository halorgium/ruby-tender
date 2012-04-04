require 'dtrace/helper'

module DTrace
  class TestObjectCreateStart < TestCase
    def test_object_create_start
      probe = <<-eoprobe
ruby#{$$}:::object-create-start
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw = trap_probe(probe) { 10.times { Object.new } }
      assert_equal 10, saw.length
    end

    def test_object_create_start_name
      probe = <<-eoprobe
ruby#{$$}:::object-create-start
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw, line = trap_probe(probe) { Hash.new }, __LINE__
      assert_equal(%w{ Hash }, saw.map { |line| line[/^\w+/] })
      assert_equal([__FILE__], saw.map { |line| line.split[1] })
      assert_equal([line.to_s], saw.map { |line| line.split[2] })
    end

    def test_object_create_start_hash_lit
      probe = <<-eoprobe
ruby#{$$}:::object-create-start
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw, line = trap_probe(probe) { {} }, __LINE__
      assert_equal(%w{ Hash }, saw.map { |line| line[/^\w+/] })
      assert_equal([__FILE__], saw.map { |line| line.split[1] })
      assert_equal([line.to_s], saw.map { |line| line.split[2] })
    end

    def test_object_create_start_array_lit
      probe = <<-eoprobe
ruby#{$$}:::object-create-start
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw, line = trap_probe(probe) { [] }, __LINE__
      assert_equal(%w{ Array }, saw.map { |line| line[/^\w+/] })
      assert_equal([__FILE__], saw.map { |line| line.split[1] })
      assert_equal([line.to_s], saw.map { |line| line.split[2] })
    end

    def test_object_create_start_string_lit
      probe = <<-eoprobe
ruby#{$$}:::object-create-start
{
  printf("%s %s %d\\n", copyinstr(arg0), copyinstr(arg1), arg2);
}
      eoprobe
      saw, line = trap_probe(probe) { "omg" }, __LINE__
      assert_equal(%w{ String }, saw.map { |line| line[/^\w+/] })
      assert_equal([__FILE__], saw.map { |line| line.split[1] })
      assert_equal([line.to_s], saw.map { |line| line.split[2] })
    end
  end
end
