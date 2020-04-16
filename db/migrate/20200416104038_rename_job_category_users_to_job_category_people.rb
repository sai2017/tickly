class RenameJobCategoryUsersToJobCategoryPeople < ActiveRecord::Migration[6.0]
  def change
    rename_table :job_category_users, :job_category_people
  end
end
