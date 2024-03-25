ActiveAdmin.register About do
    permit_params :title, :content

    ActiveAdmin.register About do
        permit_params :title, :content
      
        form do |f|
          f.inputs do
            f.input :title
            f.input :content, as: :text
          end
          f.actions
        end
      end
  end