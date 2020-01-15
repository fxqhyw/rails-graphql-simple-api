module Mutations
  class SignUpUser < BaseMutation
    class AuthProviderSignupData < Types::BaseInputObject
      argument :auth_input, Types::AuthProviderInput, required: false
    end

    argument :nickname, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    type Types::UserType

    def resolve(nickname: nil, auth_provider: nil)
      User.create!(
        nickname: nickname,
        email: auth_provider&.[](:auth_input)&.[](:email),
        password: auth_provider&.[](:auth_input)&.[](:password)
      )
    end
  end
end
