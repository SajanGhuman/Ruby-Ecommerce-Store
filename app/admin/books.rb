ActiveAdmin.register Book do
  permit_params :book_name, :book_desc, :book_author, :book_publisher, :category_id, :book_image

  remove_filter :image_attachment
  remove_filter :image_blob

  filter :category_id, as: :select, collection: Category.pluck(:category_name, :id)

  form title: 'Edit Book' do |f|
    f.semantic_errors
    
    f.inputs "Book Details" do
      f.input :book_name
      f.input :book_desc
      f.input :book_author 
      f.input :book_publisher
      f.input :category_id, as: :select, collection: Category.pluck(:category_name, :id), include_blank: false
      f.input :book_image, as: :file
    end
    
    f.actions
  end

  controller do
    def update
      @book = Book.find(params[:id])
      
      if @book.update(permitted_params[:book])
        redirect_to admin_book_path(@book)
      else
        render :edit
      end
    end 
  end 
end
