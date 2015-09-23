require 'test_helper'
require 'jch'

class JchTest < Minitest::Test
  include Jch

  def test_hasher_consistency
      key = rand(2**32..2**64-1)
      nodes = rand(1000..100000)
      node_a = hash(key, nodes)
      node_b = hash(key, nodes)
      assert_includes (0...nodes), node_a
      assert_includes (0...nodes), node_b
      assert_equal node_a, node_b
  end

  def test_rotation_on_removal
    key = rand(2**32..2**64-1)
    num_nodes = 10
    last_node = 0
    while(num_nodes > 1)
      current_node = hash(key, num_nodes)
      next_node = hash(key, num_nodes-=1)
      if(current_node != next_node) # rotation should happen
        assert next_node < current_node
        last_node = next_node # we need to test if the last node is 0 at the end
      end
    end
    assert_equal 0, last_node
  end

  def test_rotation_on_increase
    key = rand(2**32..2**64-1)
    num_nodes = 1
    while(num_nodes < 10000)
      current_node = hash(key, num_nodes)
      next_node = hash(key, num_nodes+=1)
      if(current_node != next_node) # better distribution should happen as space gets larger
        assert next_node > current_node
        last_node = next_node
      end
    end
    refute_equal 0, last_node
  end
end
