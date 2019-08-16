module ProductsHelper
  def is_user_id_current_user product
    current_user && product.user_id.equal?(current_user.id)
  end
end
