RSpec.describe Mutations::DeleteBook, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($id: ID!) {
          deleteBook(input: {
            id: $id
          }
        ) {
            book {
              id
            }
          }
        }
      GQL
    end
    let(:book) { create(:book) }
    let(:auth_header) { valid_token_header(create(:user).id) }
    let(:params) { { query: query, variables: variables } }
    let(:response_author) { JSON.parse(response.body)['data']['deleteBook'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { { 'id' => book.id } }

    include_examples 'invalid auth token'

    context 'when params is valid' do
      it 'deletes the book' do
        book
        expect do
          post '/graphql', params: params, headers: auth_header
        end.to change(Book, :count).from(1).to(0)
      end

      it 'returns the book' do
        post '/graphql', params: params, headers: auth_header
        expect(response_author).to match('book' => { 'id' => book.id.to_s })
      end

      include_examples 'returns no errors'
    end
  end
end
