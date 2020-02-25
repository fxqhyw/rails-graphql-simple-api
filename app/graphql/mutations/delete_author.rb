module Mutations
  class DeleteAuthor < BaseMutation
    argument :id, ID, required: true

    field :author, Types::AuthorType, null: true

    def resolve(id:)
      check_authentication!

      { author: Author.find(id).destroy }
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
