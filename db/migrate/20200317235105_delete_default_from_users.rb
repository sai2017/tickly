class DeleteDefaultFromUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :communication_method, :integer, default: nil, after: :want_to_connect
    change_column :users, :purpose_of_use, :integer, default: nil, after: :communication_method
  end

  def down
    change_column :users, :communication_method, :integer, default: 0, after: :want_to_connect
    change_column :users, :purpose_of_use, :integer, default: 0, after: :communication_method
  end
end
