class RemoveUserReferencesAndAddPersonReferencesToJobCategoryPeople < ActiveRecord::Migration[6.0]
  def change
    remove_reference :job_category_people, :user, index: true
    add_reference :job_category_people, :person, foreign_key: true, null: false
  end
end
