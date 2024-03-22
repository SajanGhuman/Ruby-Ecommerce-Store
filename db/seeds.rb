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

# 50.times do
#     Book.create(
#         book_name: Faker::Book.title,
#         book_desc: Faker::Lorem.paragraph,
#         book_image: "https://source.unsplash.com/random/300×300",
#         book_author: Faker::Book.author,
#         book_publisher: Faker::Book.publisher,
#         book_genre: BOOK_GENRES.sample
#     )
# end

# BOOK_GENRES.each do |name|(
#     Category.create(
#     category_name: name,
#     category_desc: Faker::Lorem.paragraph
# ))
# end

BOOK_GENRES.each do |category_name|
    category = Category.create(category_name: category_name)
    books_with_genre = Book.where(book_genre: category_name)
    category.books << books_with_genre
  end
  