class AddBirthdayColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthday, :date, after: :name
  end
end
