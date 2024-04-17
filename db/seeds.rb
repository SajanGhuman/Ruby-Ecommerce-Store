# require 'csv'

# Seed AdminUser
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

#   BOOK_GENRES = [
#     "Science Fiction",
#     "Fantasy",
#     "Mystery",
#     "Thriller",
#     "Romance",
#     "Historical Fiction",
#     "Horror",
#     "Young Adult",
#     "Non-Fiction",
#     "Biography",
#     "Self-Help",
#     "Poetry"
#   ]

#   BOOK_GENRES.each do |category_name|
#     Category.create(category_name: category_name)
#   end

#   200.times do
#     category = Category.offset(rand(Category.count)).first
#     Book.create!(
#       book_name: Faker::Book.title,
#       book_desc: Faker::Lorem.paragraph,
#       book_author: Faker::Book.author,
#       book_publisher: Faker::Book.publisher,
#       book_genre: BOOK_GENRES.sample,
#       on_sale: [true, false].sample,
#       category_id: category.id
#     )
#   end

#   csv_file = Rails.root.join('db/books.csv')
#   csv_data = File.read(csv_file)
#   books = CSV.parse(csv_data, headers: true)

#   books.each do |row|
#     category = Category.offset(rand(Category.count)).first
#     Book.create!(
#       book_name: row['title'],
#       book_desc: Faker::Lorem.paragraph,
#       book_author: Faker::Book.author,
#       book_publisher: Faker::Book.publisher,
#       book_genre: row["category"],
#       on_sale: [true, false].sample,
#       category_id: category.id
#     )
# end

# # Seed Canadian Provinces
# Province.create(name: "Alberta")
# Province.create(name: "British Columbia")
# Province.create(name: "Manitoba")
# Province.create(name: "New Brunswick")
# Province.create(name: "Newfoundland and Labrador")
# Province.create(name: "Nova Scotia")
# Province.create(name: "Ontario")
# Province.create(name: "Prince Edward Island")
# Province.create(name: "Quebec")
# Province.create(name: "Saskatchewan")
# Province.create(name: "Northwest Territories")
# Province.create(name: "Nunavut")
# Province.create(name: "Yukon")

# Book.all.each do |book|
#   book.update(book_price: Faker::Number.decimal(l_digits: 2, r_digits: 2))
# end

# db/seeds.rb

# db/seeds.rb

# Load YAML file
tax_rates_data = YAML.load_file(Rails.root.join("config/tax_rates.yml"))["tax_rates"]

# Seed TaxRates table
tax_rates_data.each do |province, rates|
  TaxRate.create!(
    province:,
    pst:      rates["pst"],
    gst:      rates["gst"],
    hst:      rates["hst"]
  )
end
