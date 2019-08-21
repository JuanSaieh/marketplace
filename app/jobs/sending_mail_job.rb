class SendingMailJob < ApplicationJob
  queue_as :default

  def perform(user, product)
    UserMailer.send_mail(user, product).deliver_now
  end
end
