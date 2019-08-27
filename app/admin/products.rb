# frozen_string_literal: true

ActiveAdmin.register Product do
  menu priority: 3
  permit_params :name,
                :description,
                :quantity,
                :price,
                :user_id,
                :category_id,
                images_attributes: %i[avatar _destroy id]

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
end
