module Mutations
  class SignUpUser < BaseMutation
    argument :first_name, String, required: true
    argument :first_name, String, required: true

    field :author, Types::AuthorType, null: true
    field :errors, [String], null: true

    def resolve(first_name: nil, last_name: nil)
      check_authentication!

      author = Author.new(first_name: first_name, last_name: last_name)
      return { errors: author.errors.full_messages } unless author.save

      { author: author }
    end
  end
end
