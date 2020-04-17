class RemoveUserReferencesAndAddPersonReferencesToCommunicationMethodPeople < ActiveRecord::Migration[6.0]
  def change
    remove_reference :communication_method_people, :user, index: true
    add_reference :communication_method_people, :person, foreign_key: true, null: false
  end
end
