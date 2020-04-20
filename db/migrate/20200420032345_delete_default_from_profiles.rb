class DeleteDefaultFromProfiles < ActiveRecord::Migration[6.0]
  def up
    change_column :profiles, :company_name, :string, default: nil, limit: 50
    change_column :profiles, :occupation, :string, default: nil, limit: 50
    change_column :profiles, :catch_copy, :string, default: nil, limit: 50
  end

  def down
    change_column :profiles, :company_name, :string, default: '', limit: 100
    change_column :profiles, :occupation, :string, default: '', limit: 100
    change_column :profiles, :catch_copy, :string, default: '', limit: 50
  end
end
