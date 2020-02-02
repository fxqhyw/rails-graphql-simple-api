RSpec.describe Book, type: :model do
  it { is_expected.to belong_to(:author) }

  it { is_expected.to validate_presence_of(:title) }
end
