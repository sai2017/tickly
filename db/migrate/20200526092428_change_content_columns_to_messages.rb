class ChangeContentColumnsToMessages < ActiveRecord::Migration[6.0]
  def up
    change_column :messages, :content, :text, null: false
  end

  def down
    change_column :messages, :content, :string, null: false
  end
end
