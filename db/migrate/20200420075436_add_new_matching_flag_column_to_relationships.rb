class AddNewMatchingFlagColumnToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_column :relationships, :new_matching_flag, :boolean, null: false, default: true, after: :new_arrival_flag
  end
end
