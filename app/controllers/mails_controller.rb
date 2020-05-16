class MailsController < ApplicationController
  before_action :if_not_admin
  def index
  end

  def create
    title = params[:title]
    content = params[:content]
    users = User.all
    users.each do |user|
      NotificationFromBareeMailer.all_notify(user, title, content).deliver
    end
    flash[:success] = '全ユーザーに送信しました'
    redirect_to mails_path
  end

  private

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
