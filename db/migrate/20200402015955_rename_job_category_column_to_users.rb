class RenameJobCategoryColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :job_category, :occupation
  end
end
