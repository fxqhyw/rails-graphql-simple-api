RSpec.describe Mutations::SignUpUser, type: :request do
  describe '#resolve' do
    let(:params) { { query: query, variables: variables } }

    context 'when query is valid' do
      let(:variables) { attributes_for(:user) }
      let(:query) do
        <<~GQL
          mutation($nickname: String!, $email: String!, $password: String!) {
            signUpUser(input: {
              nickname: $nickname,
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
              errors
            }
          }
        GQL
      end

      it 'creates a user' do
        expect do
          post '/graphql', params: params
        end.to change(User, :count).from(0).to(1)
      end

      it 'returns a user' do
        post '/graphql', params: params
        json = JSON.parse(response.body)
        user = json['data']['signUpUser']['user']

        expect(user).to include(
          'id'    => be_present,
          'email' => variables[:email]
        )
      end
    end
  end
end
