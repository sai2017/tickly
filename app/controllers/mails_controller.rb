class MailsController < ApplicationController
  before_action :if_not_admin
  def index
  end

  def create
    title = params[:title]
    content = params[:content]
    users = User.all
    if NotificationFromBareeMailer.all_notify(users, title, content).deliver
      flash[:success] = '全ユーザーに送信しました'
    else
      flash[:error] = '送信に失敗しました。'
    end
    redirect_to mails_path
  end

  private

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
