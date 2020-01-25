class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, uniqueness: true
  validates :publication_year, numericality: { only_integer: true }
end
