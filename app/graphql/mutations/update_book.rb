module Mutations
  class UpdateBook < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :author_id, ID, required: false

    field :book, Types::BookType, null: true

    def resolve(id:, **attributes)
      check_authentication!

      book = Book.find(id)
      book.update(attributes) ? { book: book } : validation_errors!(book)
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
