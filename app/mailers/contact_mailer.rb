class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact  
    mail to: ENV['CONTACT_EMAIL'], subject: "【baree】お問合わせをいただきました"
  end
end
