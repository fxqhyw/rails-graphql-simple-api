class Book < ApplicationRecord
  searchkick hughlight: %i[title description]

  belongs_to :author

  validates :title, presence: true
end
