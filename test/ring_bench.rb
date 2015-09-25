require 'test_helper'

class BenchRing < Minitest::Benchmark

  def self.bench_range
    [1,1000,10000,100000,1000000,10000000]
  end

  def bench_ring_google_numbers
    ring = Gelatin::Ring.new

    assert_performance_constant 0.99 do |n|
      (1..n).each { ring.add(Gelatin::Node.new("192.168.0.1")) }
    end

    assert_performance_constant 0.99 do |n|
      (1..n).each { ring.get("s3.amazon.com") }
    end
  end
end
