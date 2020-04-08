class AddColumnNewArrivalFlagToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_column :relationships, :new_arrival_flag, :boolean, null: false, default: true, after: :following_id
  end
end
