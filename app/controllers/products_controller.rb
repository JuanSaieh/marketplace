class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, except: [:index, :new, :create]
  before_action :is_product_from_current_user, only: [:edit, :update]

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
    unless @allow_action
      redirect_to products_path, alert: "Permission Denied - Cannot delete Products from another User"
    else
      @product.destroy
      redirect_to products_path, notice: "Product deleted successfully"
    end
    
  end

  def show; end
  
  def edit
    unless @allow_action
      redirect_to products_path, alert: "Permission Denied - Cannot edit Products from another User"
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
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

  def is_product_from_current_user
    @allow_action = current_user && current_user.id.equal?(@product.user_id)
  end

end
