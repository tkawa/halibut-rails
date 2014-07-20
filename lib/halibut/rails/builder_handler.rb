module Halibut
  module Rails
    class BuilderHandler
      def self.call(template)
        %{Halibut::Rails::ContextDelegator.setup(self); #{template.source}
          Halibut::Rails::ContextDelegator.teardown(self)}
      end
    end
  end
end
ActionView::Template.register_template_handler :halibut, Halibut::Rails::BuilderHandler
