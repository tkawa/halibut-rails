module Halibut
  module Rails
    module ContextDelegator
      attr_reader :_halibut_context

      def self.setup(context)
        context.extend(self)
        resource = Halibut::Core::Resource.new
        context._setup_delegation!(Halibut::Builder::RootContext.new(resource))
      end

      def self.teardown(context)
        # if @options[:pretty]
          JSON.pretty_generate(context._halibut_resource.to_hash)
        # else
        #   Halibut::Adapter::JSON.dump(context._halibut_resource)
        # end
      end

      def self.extended(obj)
        obj.extend(SingleForwardable)
      end

      def _setup_delegation!(halibut_context)
        @_halibut_context = halibut_context
        methods = @_halibut_context.methods - Object.instance_methods
        def_delegators(:@_halibut_context, *methods)
      end

      def _halibut_resource
        @_halibut_context.instance_variable_get(:@resource)
      end
    end
  end
end
