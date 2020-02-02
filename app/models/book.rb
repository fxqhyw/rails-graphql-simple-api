class Book < ApplicationRecord
  searchkick highlight: %i[title description]

  belongs_to :author

  validates :title, presence: true
end
