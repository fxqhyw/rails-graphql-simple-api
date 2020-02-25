module Authentication
  class UnauthorizedError < StandardError; end

  private

  attr_reader :auth_payload

  def current_user
    token = request.headers['Authorization']&.to_s
    return if token.blank?

    @auth_payload = JsonWebToken.decode(token)
    raise UnauthorizedError if invalid_payload?

    User.find(auth_payload['user_id'])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound, UnauthorizedError
    nil
  end

  def invalid_payload?
    auth_payload['user_id'].blank? || Time.at(auth_payload['exp']) < Time.current
  end
end
