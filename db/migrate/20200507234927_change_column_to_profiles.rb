class ChangeColumnToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :current_work, :text, after: :want_to_do
    remove_column :profiles, :purpose_of_working, :text
    remove_column :profiles, :weakness, :text
    remove_column :profiles, :want_to_connect, :text
  end
end
