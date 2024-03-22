ActiveAdmin.register Book do
  permit_params :book_name, :book_desc, :book_author, :book_publisher, :book_genre, :image

  remove_filter :image_attachment
  remove_filter :image_blob

  form title: 'Edit Book' do |f|
    f.semantic_errors
 
    f.inputs "Book Details" do
      f.input :book_name
      f.input :book_desc
      f.input :book_author
      f.input :book_publisher
      f.input :book_genre
      f.input :image, as: :file
    end
 
    f.actions
  end
end
