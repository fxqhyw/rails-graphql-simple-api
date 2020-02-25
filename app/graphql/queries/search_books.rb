module Queries
  class SearchBooks < BaseQuery
    type [Types::BookType], null: false

    argument :search_string, String, required: true

    def resolve(search_string:)
      ::Book.search(search_string)
    end
  end
end
