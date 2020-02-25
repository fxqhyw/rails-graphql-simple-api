RSpec.shared_examples 'returns validation errors' do
  it 'returns validation errors' do
    post '/graphql', params: params, headers: auth_header
    expect(response_errors).to match(errors)
  end
end
