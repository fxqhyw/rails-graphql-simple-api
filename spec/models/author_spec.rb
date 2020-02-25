RSpec.describe Author, type: :model do
  it { is_expected.to have_many(:books).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end
