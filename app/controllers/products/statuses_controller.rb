module Products
  class StatusesController < ApplicationController
    def update
      product = Product.find(params[:product_id])
      product.update(status: params[:status])
      if product.published?
        new_product_mail(product)
      end
      redirect_to products_path, notice: "Product status has been updated to #{params[:status]}"
    end

    private
    def new_product_mail(product)
      @all_mailers = User.except_me(product.user)
      @all_mailers.each do |user|
        SendingMailJob.perform_later(user, product)
      end
    end
  end
end
