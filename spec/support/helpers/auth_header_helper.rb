module AuthHeaderHelper
  def valid_token_header(user_id)
    { 'Authorization' => JsonWebToken.encode(user_id: user_id) }
  end

  def invalid_token_header(user_id)
    { 'Authorization' => JsonWebToken.encode({ user_id: user_id }, 1.week.ago) }
  end

  def empty_auth_header
    { 'Authorization' => '' }
  end
end
