class CreateJobCategoryUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :job_category_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
