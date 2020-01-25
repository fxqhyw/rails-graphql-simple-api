RSpec.describe Book, type: :model do
  it { is_expected.to belong_to(:author) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_numericality_of(:publication_year).only_integer }
end
