class CreateCommunicationMethodUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :communication_method_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :communication_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
