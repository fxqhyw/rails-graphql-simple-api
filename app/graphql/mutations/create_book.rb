module Mutations
  class CreateBook < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :publication_year, Integer, required: false
    argument :author_id, ID, required: true

    field :book, Types::BookType, null: true

    def resolve(title: nil, description: nil, publication_year: nil, author_id: nil)
      check_authentication!

      author = Author.find_by(id: author_id)
      book = Book.new(title: title, description: description, publication_year: publication_year, author: author)
      book.save ? { book: book } : validation_errors!(book)
    end
  end
end
