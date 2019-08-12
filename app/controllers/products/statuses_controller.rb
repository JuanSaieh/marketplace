module Products
  class StatusesController < ApplicationController
    def update
      product = Product.find(params[:product_id])
      product.update(status: params[:status])

      redirect_to products_path, notice: "Product status has been updated to #{params[:status]}"
    end
  end
end
