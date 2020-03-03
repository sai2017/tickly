class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false, default: '', limit: 100
    add_column :users, :self_introduction, :text, limit: 1000
    add_column :users, :sex, :integer, null: false, default: 0
    add_column :users, :img_name, :string
    add_column :users, :job_category, :string, default: '', limit: 100
    add_column :users, :original_experience, :text, limit: 1000
    add_column :users, :purpose_of_working, :text, limit: 1000
    add_column :users, :weakness, :text, limit: 1000
    add_column :users, :want_to_do, :text, limit: 1000
    add_column :users, :want_to_connect, :text, limit: 1000
    add_column :users, :meet_area, :string, default: '', limit: 200
  end
end
