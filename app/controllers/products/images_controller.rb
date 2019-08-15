module Products
  class ImagesController < ApplicationController
    def destroy
      ActiveStorage::Attachment.find(params[:product_id]).purge
      redirect_to edit_product_path, notice: "Image Deleted"
    end
  end
end