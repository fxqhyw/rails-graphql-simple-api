module Types
  class BookType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :publication_year, Integer, null: true
    field :author, AuthorType, null: false
  end
end
