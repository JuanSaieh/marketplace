ActiveAdmin.register Product do
  menu priority: 3
  permit_params :name, 
                :description, 
                :quantity,
                :price,
                :user_id,
                :category_id,
                images_attributes: [:avatar, :_destroy, :id]

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :quantity
      f.input :price
      f.input :user
      f.input :category
      f.input :status
    end
    f.inputs do
      f.has_many :images, allow_destroy: true do |t|
        t.input :avatar, as: :file
      end
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
