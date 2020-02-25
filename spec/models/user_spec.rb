RSpec.describe User, type: :model do
  subject { create(:user) }

  it { is_expected.to validate_presence_of(:nickname) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:nickname) }
  it { is_expected.to validate_uniqueness_of(:email) }
end
