class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    product_params = params.require(:product).permit(
      :name,
      :description,
      :quantity,
      :price,
      :user_id,
      :category_id
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
