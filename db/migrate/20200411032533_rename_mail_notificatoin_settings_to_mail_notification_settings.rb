class RenameMailNotificatoinSettingsToMailNotificationSettings < ActiveRecord::Migration[6.0]
  def change
    rename_table :mail_notificatoin_settings, :mail_notification_settings
  end
end
