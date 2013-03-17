module Importer
  module WordPress
    class Category
      attr_reader :node

      def initialize(node) 
        @node = node
      end

      def term_id
        node.xpath('wp:term_id').text
      end
      
      def name
        node.xpath('wp:cat_name').text
      end
      
      def parent
        node.xpath('wp:category_parent').text
      end
      
      def description
        node.xpath('wp:category_description').text
      end
 
      def ==(other)
        name == other.name
      end

      def to_typo
        Category.where(name: name).first_or_create(name: name, description: description)
      end
    end
  end
end
