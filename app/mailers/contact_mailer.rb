class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact  
    mail to: ENV['CONTACT_EMAIL'], subject: "【Tickly】お問合わせをいただきました"
  end
end
