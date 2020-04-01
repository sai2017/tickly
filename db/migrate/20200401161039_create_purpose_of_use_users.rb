class CreatePurposeOfUseUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :purpose_of_use_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :purpose_of_use, null: false, foreign_key: true

      t.timestamps
    end
  end
end
