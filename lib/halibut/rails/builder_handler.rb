module Halibut
  module Rails
    class BuilderHandler
      def self.call(template)
        %{ Halibut::Rails::TemplateEngine.new(#{template.source.inspect}).render(self, assigns.merge(local_assigns)) }
      end
    end
  end
end
ActionView::Template.register_template_handler :halibut, Halibut::Rails::BuilderHandler
