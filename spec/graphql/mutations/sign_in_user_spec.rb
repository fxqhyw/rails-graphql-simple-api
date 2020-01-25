RSpec.describe Mutations::SignInUser, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($email: String!, $password: String!) {
          signInUser(input: {
            authInput: {
              email: $email,
              password: $password
            }
          }
        ) {
            user {
              id
              email
            }
            token
          }
        }
      GQL
    end
    let(:params) { { query: query, variables: variables } }
    let(:response_user) { JSON.parse(response.body)['data']['signInUser'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { { email: user.email, password: user.password } }

    before { post '/graphql', params: params }

    context 'when params is valid' do
      let(:user) { create(:user) }

      it 'returns a user' do
        expect(response_user['user']).to include(
          'id'    => be_present,
          'email' => variables[:email]
        )
      end

      it 'returns a JWT token' do
        expect(response_user['token']).to be_present
      end

      it 'does not return any errors' do
        expect(response_errors).to be_nil
      end
    end

    context 'when params is invalid' do
      let(:user) { build(:user) }

      it 'does not return any user' do
        expect(response_user).to be_nil
      end

      it 'returns authentication error' do
        expect(response_errors.last['message']).to eq('Authentication failed')
      end
    end
  end
end
