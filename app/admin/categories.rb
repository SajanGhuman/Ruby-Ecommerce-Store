ActiveAdmin.register Category do
  permit_params do
    permitted = [:category_name, :category_desc, :category_image]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
    form do |f|
      f.inputs 'Category Details' do
        f.input :category_name
      end
      f.actions
    end
  
end
