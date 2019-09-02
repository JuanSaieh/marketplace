class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    omniauth_login('google')
  end

  def facebook
    omniauth_login('facebook')
  end

  def omniauth_login kind
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "#{kind.capitalize}") if is_navigational_format?
    else
      session["devise.#{kind}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end
