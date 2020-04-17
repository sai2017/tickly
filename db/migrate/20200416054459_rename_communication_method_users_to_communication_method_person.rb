class RenameCommunicationMethodUsersToCommunicationMethodPerson < ActiveRecord::Migration[6.0]
  def change
    rename_table :communication_method_users, :communication_method_people
  end
end
