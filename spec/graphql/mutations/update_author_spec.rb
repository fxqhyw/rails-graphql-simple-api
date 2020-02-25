RSpec.describe Mutations::UpdateAuthor, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($id: ID!, $first_name: String, $last_name: String, $bio: String) {
          updateAuthor(input: {
            id: $id
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
    let(:author) { create(:author) }
    let(:auth_header) { valid_token_header(create(:user).id) }
    let(:params) { { query: query, variables: variables } }
    let(:response_author) { JSON.parse(response.body)['data']['updateAuthor'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { attributes_for(:author).merge('id' => author.id) }

    include_examples 'invalid auth token'

    context 'when params is valid' do
      it 'returns an author' do
        post '/graphql', params: params, headers: auth_header
        expect(response_author).to match(
          'author' => { 'id' => author.id.to_s, 'firstName' => variables[:first_name], 'lastName' => variables[:last_name] }
        )
      end

      include_examples 'returns no errors'
    end

    context 'when required params are empty' do
      let(:variables) { { id: author.id, last_name: '', first_name: '' } }
      let(:errors) do
        [
          {
            'message' => "can't be blank",
            'extensions' => {
              'code' => Constants::INPUT_ERROR,
              'attribute' => 'first_name'
            }
          },
          {
            'message' => "can't be blank",
            'extensions' => {
              'code' => Constants::INPUT_ERROR,
              'attribute' => 'last_name'
            }
          }
        ]
      end

      it 'does not return any author' do
        post '/graphql', params: params, headers: auth_header
        expect(response_author).to be_nil
      end

      include_examples 'returns validation errors'
    end
  end
end
