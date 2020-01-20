module HeadersHelper
  def valid_token_headers(user_id)
    { 'Authorization' => V1::Lib::Auth::JsonWebToken.encode(user_id: user_id) }
  end

  def invalid_token_headers(user_id)
    { 'Authorization' => V1::Lib::Auth::JsonWebToken.encode({ user_id: user_id }, 1.week.ago) }
  end
end
