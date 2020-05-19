class AddSignUpFlagColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :signup_flag, :boolean, null: false, default: true, after: :provider
  end
end
