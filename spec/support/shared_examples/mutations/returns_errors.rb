RSpec.shared_examples 'returns errors' do
  it 'returns errors' do
    post '/graphql', params: params
    expect(response_errors).to match(errors)
  end
end
