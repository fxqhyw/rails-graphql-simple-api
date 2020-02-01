module Mutations
  class SignInUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      user = User.find_by!(email: email)
      raise UnauthorizedError unless user.authenticate(password)

      token = JsonWebToken.encode(user_id: user.id)
      { user: user, token: token }
    rescue ActiveRecord::RecordNotFound, UnauthorizedError
      raise GraphQL::ExecutionError, I18n.t('errors.unauthenticated')
    end
  end

  class UnauthorizedError < StandardError; end
end
