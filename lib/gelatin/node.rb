module Gelatin
  # Node is a PORO
  class Node
    attr_accessor :addr

    def initialize(addr)
      @addr = addr
    end

    def to_s
      @addr
    end
  end
end
