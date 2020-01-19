module Mutations
  class SignUpUser < BaseMutation
    argument :auth_input, Types::AuthProviderInput, required: false
    argument :nickname, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    def resolve(nickname: nil, auth_input: nil)
      user = User.new(nickname: nickname,
                      email: auth_input&.[](:email),
                      password: auth_input&.[](:password))
      return { errors: user.errors.full_messages } unless user.save

      { user: user }
    end
  end
end
