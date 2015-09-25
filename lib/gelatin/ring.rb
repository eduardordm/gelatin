require 'jch'

module Gelatin
  # Defines the hasher class
  # http://arxiv.org/pdf/1406.2294.pdf
  class Ring
    include Jch

    def initialize
      @nodes = []
    end

    def add(node)
      @nodes << node
    end

    def delete(node)
      @nodes.delete node
    end

    # Key should be some sort of information about the object.
    # If it's a file, maybe you could use its relative path.
    # If the object can fit in a uint64, you could use the object
    # itself as the key.
    def get(key)
      @nodes[hash(Zlib::crc32(key), @nodes.size)]
    end
  end
end
