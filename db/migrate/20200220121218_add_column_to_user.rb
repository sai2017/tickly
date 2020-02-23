class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false, default: '', limit: 100
    add_column :users, :self_introduction, :text, limit: 1000
    add_column :users, :sex, :integer, null: false, default: 0
    add_column :users, :img_name, :string
    add_column :users, :job_category, :string, null: false, default: '', limit: 100
    add_column :users, :original_experience, :text, default: '', limit: 1000
    add_column :users, :purpose_of_working, :text, null: false, default: '', limit: 1000
    add_column :users, :weakness, :text, default: '', limit: 1000
    add_column :users, :want_to_do, :text, default: '', limit: 1000
    add_column :users, :want_to_connect, :text, default: '', limit: 1000
    add_column :users, :meet_area, :string, null: false, default: '', limit: 200
  end
end
