module Types
  class QueryType < Types::BaseObject
    field :author, resolver: Queries::Author
    field :book, resolver: Queries::Book
    field :search_books, resolver: Queries::SearchBooks
  end
end
