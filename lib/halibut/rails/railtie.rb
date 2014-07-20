module Halibut
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'halibut-rails.initialize' do |app|
        ActiveSupport.on_load(:action_view) do
          require 'halibut/rails/builder_handler'
        end
      end
    end
  end
end
