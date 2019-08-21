class UserMailer < ApplicationMailer
  default from: "admin@marketplace.com"

  def send_mail(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: 'New Products in stock!')
  end
end
