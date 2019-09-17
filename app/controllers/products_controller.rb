class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, except: [:index, :new, :create]
  before_action :is_product_from_current_user, only: [:edit, :update, :destroy]

  def index
    return @products = Product.published.or(current_user.products) if current_user
    @products = Product.published
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def destroy
    if @allow_action
      @product.destroy
      redirect_to products_path, notice: 'Product deleted successfully'
    else
      redirect_to products_path, alert: 'Permission Denied - Cannot delete Products from another User'
    end
  end

  def show
    unless is_product_from_current_user_or_published
      redirect_to products_path, alert: 'Permission Denied - Cannot view unpublished Products'
    end
  end
  
  def edit
    unless @allow_action
      redirect_to products_path, alert: 'Permission Denied - Cannot edit Products from another User'
    end
  end

  def update
    if @allow_action
      if @product.update(product_params)
        redirect_to products_path, notice: 'Blog was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to products_path, notice: 'Permission Denied - Cannot update Products from another User'
    end
  end

  private
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :quantity,
      :price,
      :category_id,
      images_attributes: [:avatar, :_destroy, :id]
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def is_product_from_current_user
    @allow_action = current_user && current_user.id.equal?(@product.user_id)
  end

  def is_product_from_current_user_or_published
    is_product_from_current_user || @product.published?
  end
end
