class CreatePurposeOfUses < ActiveRecord::Migration[6.0]
  def change
    create_table :purpose_of_uses do |t|
      t.string :name

      t.timestamps
    end
  end
end
