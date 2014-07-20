module Halibut
  module Rails
    module ContextDelegator
      attr_reader :_halibut_context

      def self.setup(view_context)
        view_context.extend(self)
        view_context._setup_delegation!(Halibut::Rails::Context.new(view_context))
      end

      def self.teardown(view_context)
        # if @options[:pretty]
          JSON.pretty_generate(view_context._halibut_resource.to_hash)
        # else
        #   Halibut::Adapter::JSON.dump(context._halibut_resource)
        # end
      end

      def self.around(view_context)
        setup(view_context)
        yield
        teardown(view_context)
      end

      def self.extended(obj)
        obj.extend(SingleForwardable)
      end

      def _setup_delegation!(halibut_context)
        @_halibut_context = halibut_context
        methods = @_halibut_context.methods - Object.instance_methods
        def_delegators(:@_halibut_context, *methods)
      end

      def _swap_context(another_context, &block)
        original_context, @_halibut_context = @_halibut_context, another_context
        yield
      ensure
        @_halibut_context = original_context
      end

      def _halibut_resource
        @_halibut_context.instance_variable_get(:@resource)
      end
    end
  end
end
