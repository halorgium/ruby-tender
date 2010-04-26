require_relative 'helper'

module Fiddle
  class TestFunction < Fiddle::TestCase
    def test_default_abi
      func = Function.new(@libm['sin'], [TYPE_DOUBLE], TYPE_DOUBLE)
      assert_equal Function::DEFAULT, func.abi
    end

    def test_argument_errors
      assert_raises(TypeError) do
        Function.new(@libm['sin'], TYPE_DOUBLE, TYPE_DOUBLE)
      end

      assert_raises(TypeError) do
        Function.new(@libm['sin'], ['foo'], TYPE_DOUBLE)
      end

      assert_raises(TypeError) do
        Function.new(@libm['sin'], [TYPE_DOUBLE], 'foo')
      end
    end

    def test_call
      func = Function.new(@libm['sin'], [TYPE_DOUBLE], TYPE_DOUBLE)
      assert_in_delta 1.0, func.call(90 * Math::PI / 180), 0.0001
    end
  end
end
