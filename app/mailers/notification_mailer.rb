class NotificationMailer < ActionMailer::Base

  default :from => "abhishek@mobicube.mygbiz.com"
  default :to => "abhishek@mobicube.mygbiz.com"

  def new_message(message)
    @message = message
    mail subject: "#{message.subject}"
  end

end