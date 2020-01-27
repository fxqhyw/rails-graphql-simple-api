module Queries
  class Authors < BaseQuery
    description 'Find all authors'

    type [Types::AuthorType], null: false

    def resolve
      ::Author.all
    end
  end
end
