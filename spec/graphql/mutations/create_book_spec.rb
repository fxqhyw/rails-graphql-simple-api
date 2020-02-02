RSpec.describe Mutations::CreateBook, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($title: String!, $description: String, $author_id: ID!) {
          createBook(input: {
            title: $title,
            description: $description,
            authorId: $author_id
          }
        ) {
            book {
              id
              title
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
    let(:params) { { query: query, variables: variables } }
    let(:auth_header) { valid_token_header(create(:user).id) }
    let(:response_book) { JSON.parse(response.body)['data']['createBook'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { attributes_for(:book).merge(author_id: author.id) }

    include_examples 'invalid auth token'

    context 'when params is valid' do
      it 'creates a book' do
        expect do
          post '/graphql', params: params, headers: auth_header
        end.to change(Book, :count).from(0).to(1)
      end

      it 'returns a book and author' do
        post '/graphql', params: params, headers: auth_header
        expect(response_book).to match(
          'book' => {
            'id' => be_present,
            'title' => variables[:title],
            'author' => {
              'id' => author.id.to_s,
              'firstName' => author.first_name,
              'lastName' => author.last_name
            }
          }
        )
      end

      include_examples 'returns no errors'
    end

    context 'when params are invalid' do
      let(:variables) { { title: '', author_id: '111' } }
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

      it 'does not create a book' do
        expect do
          post '/graphql', params: params, headers: auth_header
        end.not_to change(Book, :count)
      end

      it 'does not return any book' do
        post '/graphql', params: params, headers: auth_header
        expect(response_book).to be_nil
      end

      include_examples 'returns validation errors'
    end
  end
end
