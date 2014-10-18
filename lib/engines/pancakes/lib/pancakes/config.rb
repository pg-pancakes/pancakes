module Pancakes

  def self.setup
    yield self
  end

  mattr_accessor :standalone
  @@standalone = false

end