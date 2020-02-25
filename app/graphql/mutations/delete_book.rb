module Mutations
  class DeleteBook < BaseMutation
    argument :id, ID, required: true

    field :book, Types::BookType, null: true

    def resolve(id:)
      check_authentication!

      { book: Book.find(id).destroy }
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
