ActiveAdmin.register Order do
    permit_params :status, :shipping_status

    index do
      selectable_column
      id_column
      
      column :status
      column :shipping_status 
      actions
    end
  
    form do |f|
      f.inputs "Order Details" do
        f.input :status, as: :select, collection: Order.statuses.keys
        f.input :shipping_status, as: :select, collection: Order.shipping_statuses.keys
      end
      f.actions
    end
  end
  