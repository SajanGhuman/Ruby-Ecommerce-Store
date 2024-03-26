  require 'csv'

  # Seed AdminUser
  # AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

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

  BOOK_GENRES.each do |category_name|
    Category.create(category_name: category_name)
  end


  50.times do
    category = Category.offset(rand(Category.count)).first
    Book.create!(
      book_name: Faker::Book.title,
      book_desc: Faker::Lorem.paragraph,
      book_author: Faker::Book.author,
      book_publisher: Faker::Book.publisher,
      book_genre: BOOK_GENRES.sample,
      category_id: category.id
    )
  end

  csv_file = Rails.root.join('db/books.csv')
  csv_data = File.read(csv_file)
  books = CSV.parse(csv_data, headers: true)


  books.each do |row|
    category = Category.offset(rand(Category.count)).first
    Book.create!(
      book_name: row['title'],
      book_desc: Faker::Lorem.paragraph,
      book_author: Faker::Book.author,
      book_publisher: Faker::Book.publisher,
      book_genre: row["category"],
      category_id: category.id
    ) 
end