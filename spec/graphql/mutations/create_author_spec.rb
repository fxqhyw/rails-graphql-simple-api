RSpec.describe Mutations::CreateAuthor, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($first_name: String!, $last_name: String!, $bio: String) {
          createAuthor(input: {
            firstName: $first_name,
            lastName: $last_name,
            bio: $bio
          }
        ) {
            author {
              id
              firstName
              lastName
            }
          }
        }
      GQL
    end
    let(:params) { { query: query, variables: variables } }
    let(:auth_header) { valid_token_header(create(:user).id) }
    let(:response_author) { JSON.parse(response.body)['data']['createAuthor'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { attributes_for(:author) }

    include_examples 'invalid auth token'

    context 'when params is valid' do
      it 'creates an author' do
        expect do
          post '/graphql', params: params, headers: auth_header
        end.to change(Author, :count).from(0).to(1)
      end

      it 'returns an author' do
        post '/graphql', params: params, headers: auth_header
        expect(response_author).to match(
          'author' => { 'id' => be_present, 'firstName' => variables[:first_name], 'lastName' => variables[:last_name] }
        )
      end

      include_examples 'returns no errors'
    end

    context 'when required params are empty' do
      let(:variables) { { last_name: '', first_name: '' } }
      let(:errors) do
        [
          {
            'message' => "can't be blank",
            'extensions' => {
              'code' => 'INPUT_ERROR',
              'attribute' => 'first_name'
            }
          },
          {
            'message' => "can't be blank",
            'extensions' => {
              'code' => 'INPUT_ERROR',
              'attribute' => 'last_name'
            }
          }
        ]
      end

      it 'does not create an author' do
        expect do
          post '/graphql', params: params, headers: auth_header
        end.not_to change(Author, :count)
      end

      it 'does not return any author' do
        post '/graphql', params: params, headers: auth_header
        expect(response_author).to be_nil
      end

      include_examples 'returns validation errors'
    end
  end
end
