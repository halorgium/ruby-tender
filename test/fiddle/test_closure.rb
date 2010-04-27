require_relative 'helper'

module Fiddle
  class TestClosure < Fiddle::TestCase
    def test_argument_errors
      assert_raises(TypeError) do
        Closure.new(TYPE_INT, TYPE_INT)
      end

      assert_raises(TypeError) do
        Closure.new('foo', [TYPE_INT])
      end

      assert_raises(TypeError) do
        Closure.new(TYPE_INT, ['meow!'])
      end
    end

    def test_call
      closure = Class.new(Closure) {
        def call
          10
        end
      }.new(TYPE_INT, [])

      func = Function.new(closure, [], TYPE_INT)
      assert_equal 10, func.call
    end

    def test_returner
      closure = Class.new(Closure) {
        def call thing
          thing
        end
      }.new(TYPE_INT, [TYPE_INT])

      func = Function.new(closure, [TYPE_INT], TYPE_INT)
      assert_equal 10, func.call(10)
    end
  end
end
