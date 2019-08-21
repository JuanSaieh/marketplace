module UsersHelper
  def is_user_current_user user
    current_user && current_user.id.equal?(user.id)
  end
end
