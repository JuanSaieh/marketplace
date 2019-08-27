# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 2
  permit_params :first_name,
                :last_name,
                :email,
                :cellphone,
                :address,
                :password,
                :password_confirmation,
                products_attributes: [
                  :name,
                  :description,
                  :quantity,
                  :price,
                  :category_id,
                  :user_id,
                  :_destroy,
                  :id,
                  image_attributes: %i[avatar _destroy id]
                ]

  index do
    id_column
    column :first_name
    column :last_name
    column :email
    column :cellphone
    column :address
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :cellphone
      f.input :address
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.has_many :products, allow_destroy: true do |t|
        t.input :name
        t.input :description
        t.input :quantity
        t.input :price
        t.input :category
        t.has_many :images, allow_destroy: true do |i|
          i.input :avatar, as: :file
        end
      end
    end
    f.actions
  end
end
