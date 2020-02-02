RSpec.describe Mutations::DeleteAuthor, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($id: ID!) {
          deleteAuthor(input: {
            id: $id
          }
        ) {
            author {
              id
            }
          }
        }
      GQL
    end
    let(:author) { create(:author) }
    let(:auth_header) { valid_token_header(create(:user).id) }
    let(:params) { { query: query, variables: variables } }
    let(:response_author) { JSON.parse(response.body)['data']['deleteAuthor'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { { 'id' => author.id } }

    include_examples 'invalid auth token'

    context 'when params is valid' do
      it 'deletes an author' do
        author
        expect do
          post '/graphql', params: params, headers: auth_header
        end.to change(Author, :count).from(1).to(0)
      end

      it 'returns an author' do
        post '/graphql', params: params, headers: auth_header
        expect(response_author).to match('author' => { 'id' => author.id.to_s })
      end

      include_examples 'returns no errors'
    end
  end
end
