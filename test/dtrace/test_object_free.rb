require 'dtrace/helper'

module DTrace
  class TestObjectFree < TestCase
    class Foo
    end

    def test_object_free
      probe = <<-eoprobe
ruby#{$$}:::object-free
{
  printf("%s\\n", copyinstr(arg0));
}
      eoprobe
      GC.stress = true
      saw = trap_probe(probe) { 10.times { Foo.new } }
      assert_equal 10, saw.length
    end
  end
end

