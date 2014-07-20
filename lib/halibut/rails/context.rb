module Halibut
  module Rails
    class Context < Halibut::Builder::RootContext
      def initialize(view_context, options = {})
        @view_context = view_context
        @resource = Halibut::Core::Resource.new(options[:href])
      end

      def _resource
        @resource
      end

      # Adds an embedded resource.
      #
      # @param [String] rel  Embedded resource relation to the parent resource
      # @param [String] href URI to the resource itself
      # @param [Proc]   blk  Instructions to construct the embedded resource
      def resource(rel, href=nil, &embedded_definition)
        embedded = self.class.new(@view_context, href: href)
        @view_context._swap_context(embedded, &embedded_definition) if block_given?
        @resource.embed_resource(rel, embedded._resource)
      end

      # Adds links or resources to a relation.
      #
      # Relation allows the user to specify links, or resources, per relation,
      # instead of individually.
      # This feature was introduced as an attempt to reduce repeating the
      # relation per link/resource, and thus reducing typos.
      #
      #     resource = Halibut::Builder.new do
      #       relation :john do
      #         link 'http://appleseed.com/john'
      #       end
      #     end.resource
      #     resource.links[:john].first.href
      #
      # @param [String,Symbol] rel
      # @param [Proc]          blk Instructions to be executed in the relation
      #                            context
      def relation(rel, &relation_definition)
        raise NotImplementedError, 'relation is not supported yet'
      end
    end

    # RelationContext is not supported yet
    # class RelationContext < Halibut::Builder::RelationContext
    # end
  end
end
