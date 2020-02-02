RSpec.describe Mutations::UpdateBook, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($id: ID!, $title: String, $description: String, $author_id: ID) {
          updateBook(input: {
            id: $id,
            title: $title,
            description: $description,
            authorId: $author_id
          }
        ) {
            book {
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
    let(:author) { create(:author) }
    let(:book) { create(:book) }
    let(:params) { { query: query, variables: variables } }
    let(:auth_header) { valid_token_header(create(:user).id) }
    let(:response_book) { JSON.parse(response.body)['data']['updateBook'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { attributes_for(:book).merge(id: book.id, author_id: author.id) }

    include_examples 'invalid auth token'

    context 'when params is valid' do
      it 'returns updated book and author' do
        post '/graphql', params: params, headers: auth_header
        expect(response_book).to match(
          'book' => {
            'id' => book.id.to_s,
            'title' => variables[:title],
            'description' => variables[:description],
            'author' => {
              'id' => variables[:author_id].to_s,
              'firstName' => author.first_name,
              'lastName' => author.last_name
            }
          }
        )
      end

      include_examples 'returns no errors'
    end

    context 'when params are invalid' do
      let(:variables) { { id: book.id, title: '', author_id: 111 } }
      let(:errors) do
        [
          {
            'message' => 'must exist',
            'extensions' => {
              'code' => 'INPUT_ERROR',
              'attribute' => 'author'
            }
          },
          {
            'message' => "can't be blank",
            'extensions' => {
              'code' => 'INPUT_ERROR',
              'attribute' => 'title'
            }
          }
        ]
      end

      it 'does not return any book' do
        post '/graphql', params: params, headers: auth_header
        expect(response_book).to be_nil
      end

      include_examples 'returns validation errors'
    end
  end
end
