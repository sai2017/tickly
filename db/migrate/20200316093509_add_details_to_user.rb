class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age, :integer, after: :name
    add_column :users, :company_name, :string, default: '', limit: 100, after: :age
    add_column :users, :catch_copy, :string, default: '', limit: 50, after: :job_category
    add_column :users, :communication_method, :integer, default: 0, after: :want_to_connect
    add_column :users, :purpose_of_use, :integer, default: 0, after: :communication_method
  end
end
