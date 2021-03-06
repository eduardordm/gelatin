$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gelatin'

require 'minitest/autorun'
require "minitest/benchmark"

require 'securerandom'


def valid_v4?(addr)
  if /\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\Z/ =~ addr
    return $~.captures.all? {|i| i.to_i < 256}
  end
  return false
end
