class CreateLikePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :like_points do |t|
      t.integer :balance, default: 0, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
