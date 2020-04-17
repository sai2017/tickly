class RemoveUserReferencesAndAddPersonReferencesToPurposeOfUsePeople < ActiveRecord::Migration[6.0]
  def change
    remove_reference :purpose_of_use_people, :user, index: true
    add_reference :purpose_of_use_people, :person, foreign_key: true, null: false
  end
end
