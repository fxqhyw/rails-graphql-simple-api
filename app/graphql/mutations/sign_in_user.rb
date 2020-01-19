module Mutations
  class SignInUser < BaseMutation
    argument :auth_input, Types::AuthProviderInput, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(auth_input: nil)
      user = User.find_by!(email: auth_input[:email])
      raise UnauthorizedError unless user.authenticate(auth_input[:password])

      token = JsonWebToken.encode(user_id: user.id)
      { user: user, token: token }
    rescue ActiveRecord::RecordNotFound, UnauthorizedError
      raise GraphQL::ExecutionError, I18n.t('errors.unauthenticated')
    end
  end

  class UnauthorizedError < StandardError; end
end
