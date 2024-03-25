ActiveAdmin.register Category do
  permit_params do
    permitted = [:category_name, :category_desc, :category_image]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
