require 'fiddle.so'
require 'fiddle/function'
require 'dl'

module Fiddle
  Pointer = DL::CPtr

  if WINDOWS
    def self.win32_last_error
      Thread.current[:__FIDDLE_WIN32_LAST_ERROR__]
    end

    def self.win32_last_error= error
      Thread.current[:__FIDDLE_WIN32_LAST_ERROR__] = error
    end
  end

  def self.last_error
    Thread.current[:__FIDDLE_LAST_ERROR__]
  end

  def self.last_error= error
    Thread.current[:__FIDDLE_LAST_ERROR__] = error
  end
end
