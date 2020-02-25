class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :first_name, :last_name, presence: true
end
