module Mutations
  class SignUpUser < BaseMutation
    class AuthProviderSignupData < Types::BaseInputObject
      argument :auth_input, Types::AuthProviderInput, required: false
    end
    argument :nickname, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    def resolve(nickname: nil, auth_provider: nil)
      user = User.new(nickname: nickname,
                      email: auth_provider&.[](:auth_input)&.[](:email),
                      password: auth_provider&.[](:auth_input)&.[](:password))
      return { errors: user.errors.full_messages } unless user.save

      { user: user }
    end
  end
end
