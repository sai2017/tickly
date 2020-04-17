class RemoveProfileColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :name
    remove_column :users, :birthday
    remove_column :users, :company_name
    remove_column :users, :self_introduction
    remove_column :users, :img_name
    remove_column :users, :occupation
    remove_column :users, :catch_copy
    remove_column :users, :original_experience
    remove_column :users, :purpose_of_working
    remove_column :users, :weakness
    remove_column :users, :want_to_do
    remove_column :users, :want_to_connect
    remove_column :users, :prefecture_id
  end
end
