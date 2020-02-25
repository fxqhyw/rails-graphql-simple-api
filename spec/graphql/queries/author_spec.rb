RSpec.describe Queries::Author, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        query($id: ID!) {
          author(
            id: $id
          ) {
            id
            firstName
            lastName
            books {
              id
            }
          }
        }
      GQL
    end
    let(:author) { create(:author) }
    let(:auth_header) { empty_auth_header }
    let(:params) { { query: query, variables: variables } }
    let(:response_data) { JSON.parse(response.body)['data'] }
    let(:response_author) { JSON.parse(response.body)['data']['author'] }
    let(:response_errors) { JSON.parse(response.body)['errors'] }
    let(:variables) { { id: author.id } }

    context 'when id is valid' do
      before { create_list(:book, 3, author: author) }

      it 'returns the author' do
        post '/graphql', params: params
        expect(response_author).to match(
          'id' => author.id.to_s,
          'firstName' => author.first_name,
          'lastName' => author.last_name,
          'books' => author.books.pluck(:id).map { |id| { 'id' => id.to_s } }
        )
      end

      include_examples 'returns no errors'
    end

    context 'when params are invalid' do
      let(:variables) { { id: 1111 } }

      before { post '/graphql', params: params }

      it 'returns an error' do
        expect(response_errors[0]).to include(
          'extensions' => {
            'code' => Constants::INPUT_ERROR
          }
        )
      end

      it 'does not return any data' do
        expect(response_data).to be_nil
      end
    end
  end
end
