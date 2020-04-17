class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string     :name, limit: 100
      t.date       :birthday
      t.string     :company_name, default: '', limit: 100
      t.text       :self_introduction, limit: 1000
      t.string     :img_name
      t.string     :occupation, default: '', limit: 100
      t.string     :catch_copy, default: '', limit: 50
      t.text       :original_experience, limit: 1000
      t.text       :purpose_of_working, limit: 1000
      t.text       :weakness, limit: 1000
      t.text       :want_to_do, limit: 1000
      t.text       :want_to_connect, limit: 1000
      t.references :person, null: false, foreign_key: true
      t.references :prefecture, foreign_key: true

      t.timestamps
    end
  end
end