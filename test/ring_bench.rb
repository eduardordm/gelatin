require 'test_helper'

class BenchRing < Minitest::Benchmark
  def bench_ring_google_numbers
    ring = Gelatin::Ring.new

    assert_performance_constant 0.1800000 do
      ring.add(Gelatin::Node.new("192.168.0.1"))
    end

    assert_performance_constant 0.10000 do
      (1..100000).each { ring.get(Item.new.key) }
    end
  end
end
