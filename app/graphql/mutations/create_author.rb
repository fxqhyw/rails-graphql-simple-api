module Mutations
  class CreateAuthor < BaseMutation
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :bio, String, required: false

    field :author, Types::AuthorType, null: true

    def resolve(first_name:, last_name:, bio: nil)
      check_authentication!

      author = Author.new(first_name: first_name, last_name: last_name, bio: bio)
      author.save ? { author: author } : validation_errors!(author)
    end
  end
end
