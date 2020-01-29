module Mutations
  class UpdateAuthor < BaseMutation
    argument :id, ID, required: true
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :bio, String, required: false

    field :author, Types::AuthorType, null: true

    def resolve(id:, **args)
      check_authentication!

      author = Author.find(id)
      author.update(args) ? { author: author } : validation_errors!(author)
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
