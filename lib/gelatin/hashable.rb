module Gelatin
  module Hashable
    def key
      self.to_s.unpack('q*').first
    end
  end
end
