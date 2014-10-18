module Pancakes
  class Engine < ::Rails::Engine
    isolate_namespace Pancakes

    initializer "pancakes.connection" do
      $pg = Struct.new(:connection).new
    end
  end
end
