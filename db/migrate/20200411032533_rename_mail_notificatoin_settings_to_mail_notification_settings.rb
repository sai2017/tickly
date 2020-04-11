class RenameMailNotificationSettingsToMailNotificationSettings < ActiveRecord::Migration[6.0]
  def change
    rename_table :mail_notification_settings, :mail_notification_settings
  end
end
