require 'dl.so'
require 'fiddle'

module DL
  def self.fiddle?
    Object.const_defined?(:Fiddle)
  end
end
