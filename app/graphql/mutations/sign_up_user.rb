module Mutations
  class SignUpUser < BaseMutation
    argument :auth_input, Types::AuthProviderInput, required: false
    argument :nickname, String, required: true

    field :user, Types::UserType, null: true

    def resolve(nickname: nil, auth_input: nil)
      user = User.new(nickname: nickname,
                      email: auth_input&.[](:email),
                      password: auth_input&.[](:password))
      user.save ? { user: user } : validation_errors!(user)
    end
  end
end
