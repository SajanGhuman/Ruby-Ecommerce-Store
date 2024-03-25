# AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

BOOK_GENRES = [
  "Science Fiction",
  "Fantasy",
  "Mystery",
  "Thriller",
  "Romance",
  "Historical Fiction", 
  "Horror",
  "Young Adult",
  "Non-Fiction",
  "Biography",
  "Self-Help",
  "Poetry"
]

BOOK_GENRES.each do |c|
  Category.create(
    category_name: c
  )
end

50.times do
  Book.create!(
    book_name: Faker::Book.title,
    book_desc: Faker::Lorem.paragraph,
    book_author: Faker::Book.author,
    book_publisher: Faker::Book.publisher,
    category_id: Category.pluck(:id).sample
  )
end