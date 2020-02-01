RSpec.shared_examples 'invalid auth token' do
  context 'when auth token is invalid' do
    let(:auth_header) { invalid_token_header(create(:user).id) }

    it 'returns authentication error' do
      post '/graphql', params: params, headers: auth_header
      expect(response_errors[0]).to include('message' => 'You need to authenticate for perform this action')
    end
  end
end
