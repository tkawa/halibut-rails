module Halibut
  module Rails
    class TemplateEngine
      EXCLUDE_INSTANCE_VARIABLES = %w(@assigns @helpers @resource).freeze

      def initialize(source, options = {})
        @source = source
        @options = options
        @builder = Halibut::Builder.new
        @root_context = Halibut::Builder::RootContext.new(@builder.resource)
      end

      def render(scope, locals = {}, &block)
        set_instance_variables(scope)
        # TODO: set delegation to context scope
        exec_source(locals)
        to_json
      end

      def to_hash
        @builder.resource.to_hash
      end

      def to_json
        if @options[:pretty]
          JSON.pretty_generate(to_hash)
        else
          Halibut::Adapter::JSON.dump(@builder.resource)
        end
      end

      private
      def set_instance_variables(scope)
        @scope = scope
        variables = scope.instance_variables.map(&:to_s) - EXCLUDE_INSTANCE_VARIABLES
        variables.each do |name|
          @root_context.instance_variable_set(name, scope.instance_variable_get(name))
        end
      end

      def exec_source(locals)
        # TODO: eval locals
        if @options[:source_location]
          @root_context.instance_eval(@source, @options[:source_location])
        else
          @root_context.instance_eval(@source)
        end
      end
    end
  end
end
