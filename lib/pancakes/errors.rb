module Pancakes
  module Errors

    class NoConnection < StandardError
      def initialize
        super 'No connection was found! Try calling Pancakes::Database.connect first.'
      end
    end

    class InvalidQuery < StandardError
      def initialize(query, msg = 'is invalid')
        msg = "#{query} #{msg}."
        msg = 'Query is empty!' if query.blank?
        super
      end
    end

  end
end
