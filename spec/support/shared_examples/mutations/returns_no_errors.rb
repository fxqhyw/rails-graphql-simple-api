RSpec.shared_examples 'returns no errors' do
  it 'does not returns any errors' do
    post '/graphql', params: params, headers: auth_header
    expect(response_errors).to be_nil
  end
end
