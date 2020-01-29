module Types
  class MutationType < Types::BaseObject
    field :sign_up_user, mutation: Mutations::SignUpUser
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_author, mutation: Mutations::CreateAuthor
    field :create_book, mutation: Mutations::CreateBook
    field :update_book, mutation: Mutations::UpdateBook
  end
end
