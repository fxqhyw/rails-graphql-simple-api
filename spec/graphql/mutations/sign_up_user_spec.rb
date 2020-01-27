RSpec.describe Mutations::SignUpUser, type: :request do
  describe '#resolve' do
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
          }
        }
      GQL
    end
    let(:params) { { query: query, variables: variables } }
    let(:response_user) { JSON.parse(response.body)['data']['signUpUser'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }

    context 'when params is valid' do
      let(:variables) { attributes_for(:user) }

      it 'creates a user' do
        expect do
          post '/graphql', params: params
        end.to change(User, :count).from(0).to(1)
      end

      it 'returns a user' do
        post '/graphql', params: params
        expect(response_user).to match(
          'user' => { 'id' => be_present, 'email' => variables[:email] }
        )
      end

      it 'does not returns any errors' do
        post '/graphql', params: params
        expect(response_errors).to be_nil
      end
    end

    context 'when params is invalid' do
      let(:variables) { { email: '', nickname: '', password: '123456' } }
      let(:errors) do
        [
          {
            'message' => "can't be blank",
            'extensions' => {
              'code' => 'INPUT_ERROR',
              'attribute' => 'nickname'
            }
          },
          {
            'message' => "can't be blank",
            'extensions' => {
              'code' => 'INPUT_ERROR',
              'attribute' => 'email'
            }
          }
        ]
      end

      it 'does not create a user' do
        expect do
          post '/graphql', params: params
        end.not_to change(User, :count)
      end

      it 'does not return any user' do
        post '/graphql', params: params
        expect(response_user).to be_nil
      end

      it 'returns errors' do
        post '/graphql', params: params
        expect(response_errors).to match(errors)
      end
    end
  end
end
