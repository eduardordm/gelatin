require 'test_helper'

class RingTest < Minitest::Test
  def test_that_it_finds_a_server
    sh = Gelatin::Ring.new
    (1...254).each do |i|
      sh.add Gelatin::Node.new("192.168.0.#{i}")
    end
    refute_nil sh.get("s3.amazon.com")
    assert valid_v4? sh.get("s3.amazon.com").addr
  end
end
