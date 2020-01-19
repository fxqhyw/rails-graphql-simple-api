class ApplicationController < ActionController::API
  private

  attr_reader :auth_payload

  def current_user
    token = request.headers['Authorization'].to_s
    @auth_payload = JsonWebToken.decode(token)[0]
    return if invalid_payload?

    User.find_by(id: auth_payload['user_id'])
  end

  def invalid_payload?
    auth_payload['user_id'].blank? || Time.at(auth_payload['exp']) < Time.current
  end
end
