module Halibut
  module Rails
    class BuilderHandler
      def self.call(template)
        %{Halibut::Rails::ContextDelegator.around(self){ #{template.source} } }
      end
    end
  end
end
ActionView::Template.register_template_handler :halibut, Halibut::Rails::BuilderHandler
