module Importer
  module WordPress
    class Post < Page
      def tags
        # xml dump has "post_tag" for wordpress 3.1 and "tag" for 3.0
        path = if node.xpath("category[@domain='post_tag']").count > 0
          "category[@domain='post_tag']"
        else
          "category[@domain='tag']"
        end

        node.xpath(path).collect do |tag_node| 
          ::Tag.where(name: tag_node['nicename']).first_or_create(name: tag_node['nicename'], display_name: tag_node.text)
        end
      end

      def categories
        node.xpath("category[@domain='category']").collect do |cat|
          ::Category.where(name: cat['nicename']).first_or_create(name: cat['nicename'], description: cat.text)
        end
      end

      def comments
        node.xpath("wp:comment").collect do |comment_node|
          Comment.new(comment_node)
        end
      end

      def to_typo
        user = ::User.where(login: creator).first || ::User.first
        raise "Referenced User doesn't exist! Make sure the authors are imported first." \
          unless user

        begin
          post = ::Article.new :title => title, :body => content_formatted,
            :draft => draft?, :published_at => post_date, :created_at => post_date,
            :user_id => user.id
          post.save!

          ::Article.transaction do
            post.tags = tags
            post.categories = categories
          end
        rescue ActiveRecord::RecordInvalid
          # if the title has already been taken (WP allows duplicates here,
          # refinery doesn't) append the post_id to it, making it unique
          post.title = "#{title}-#{post_id}"
          post.save
        end

        post
      end

      def self.create_blog_page_if_necessary
      end

    end
  end
end
