User.create(nickname: 'booker', email: 'admin@admin.com', password: '123456')
100.times do
  author = FactoryBot.create(:author)

  rand(1..8).times { FactoryBot.create(:book, author: author) }
end
