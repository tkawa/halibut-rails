module Halibut
  module Rails
    class BuilderHandler
      def self.call(template)
        %{assigns = @_assigns.dup; assigns.delete('resource'); builder = Halibut::Builder.new; root_context = Halibut::Builder::RootContext.new(builder.resource){ assigns.each{|var, value| instance_variable_set("@\#{var}", value) } }; root_context.instance_eval{ #{template.source} }; JSON.pretty_generate(builder.resource.to_hash)}
      end
    end
  end
end
ActionView::Template.register_template_handler :halibut, Halibut::Rails::BuilderHandler
