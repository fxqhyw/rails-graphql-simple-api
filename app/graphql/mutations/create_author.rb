module Mutations
  class CreateAuthor < BaseMutation
    argument :first_name, String, required: true
    argument :first_name, String, required: true

    field :author, Types::AuthorType, null: true

    def resolve(first_name: nil, last_name: nil)
      check_authentication!

      author = Author.new(first_name: first_name, last_name: last_name)
      author.save ? { author: author } : validation_errors!(author)
    end
  end
end
