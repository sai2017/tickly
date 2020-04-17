class RenamePurposeOfUseUsersToPurposeOfUsePeople < ActiveRecord::Migration[6.0]
  def change
    rename_table :purpose_of_use_users, :purpose_of_use_people
  end
end
