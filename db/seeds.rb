User.create!(nickname: 'booker', email: 'admin@admin.com', password: '123456')
1000.times { FactoryBot.create(:book) }
