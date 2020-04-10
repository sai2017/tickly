class SettingsController < ApplicationController
  def index
    @mail_notification_setting = MailNotificatoinSetting.find_by(user_id: current_user.id)
  end

  def create
    @mail_notification_setting = MailNotificatoinSetting.find_by(user_id: current_user.id)
    if @mail_notification_setting.update(setting_params)
      flash[:success] = "設定を更新しました"
    else
      flash[:error] = '設定の更新に失敗しました。' 
    end
    redirect_back(fallback_location: settings_path)
  end

  private

  def setting_params
    params.permit(:message_flag, :like_flag, :matching_flag)
  end
end
