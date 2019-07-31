class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy]

  def index
    @products = Product.all
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def set_product
    @product = Product.find(params[:id])
  end
end