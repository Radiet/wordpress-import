module Importer
  module WordPress
    class Author
      attr_reader :author_node

      def initialize(author_node)
        @author_node = author_node
      end

      def login
        author_node.xpath("wp:author_login").text
      end

      def email
        author_node.xpath("wp:author_email").text
      end
      
      def name
        author_node.xpath("wp:display_name").text
      end

      def ==(other)
        login == other.login
      end

      def inspect
        "WordPress::Author: #{login} <#{email}>"
      end

      def to_typo
        user = User.where(login: login).first_or_create(login: login, email: email, name: name, 
                    password: "password", password_confirmation: "password")
      end
    end
  end
end
