module Queries
  class Author < Queries::BaseQuery
    description 'Find an author by ID'

    argument :id, ID, required: true

    type Types::AuthorType, null: false

    def resolve(id:)
      ::Author.find(id)
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
