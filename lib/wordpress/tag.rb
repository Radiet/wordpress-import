module Importer
  module WordPress
    class Tag
      attr_accessor :node

#      <wp:tag>
#        <wp:term_id>496</wp:term_id>
#        <wp:tag_slug>15-day-fat-blast</wp:tag_slug>
#        <wp:tag_name><![CDATA[15-Day Fat Blast]]></wp:tag_name>
#      </wp:tag>

      def initialize(node)
        @node = node
      end

      def ==(other)
        node.name == other.name
      end

      def id
        node.xpath("wp:term_id").text
      end
      
      def name
        node.xpath("wp:tag_slug").text
      end
      
      def display_name
        node.xpath("wp:tag_name").text
      end
      
      def to_typo
        Tag.where(name: name).first_or_create(name: name, display_name: name)
      end
    end
  end
end
