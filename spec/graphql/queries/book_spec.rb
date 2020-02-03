RSpec.describe Queries::Book, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($id: ID!) {
          query {
            book(
              id: $id
            ) {
              id
              title
              description
              author {
                id
                firstName
                lastName
              }
            }
          }
        }
      GQL
    end
    let(:book) { create(:book) }
    let(:params) { { query: query, variables: variables } }
    let(:response_book) { JSON.parse(response.body)['data']['book'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { { id: book.id } }

    context 'when id is valid' do
      it 'returns the book' do
        post '/graphql', params: params
        expect(response_book).to match(
          'book' => {
            'id' => book.id.to_s,
            'title' => book.title,
            'description' => book.description,
            'author' => {
              'id' => book.author_id.to_s,
              'firstName' => book.author.first_name,
              'lastName' => book.author.last_name
            }
          }
        )
      end

      include_examples 'returns no errors'
    end

    context 'when params are invalid' do
      let(:variables) { { id: 111 } }

      before { post '/graphql', params: params }

      it 'returns an error' do
        expect(response_errors[0]).to include(
          'extensions' => {
            'code' => Constants::INPUT_ERROR
          }
        )
      end

      it 'does not return any book' do
        expect(response_book).to be_nil
      end
    end
  end
end
