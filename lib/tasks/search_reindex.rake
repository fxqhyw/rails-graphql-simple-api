namespace :books do
  desc 'Update search index'
  task reindex: :environment do
    Book.reindex
  end
end
