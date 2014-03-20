class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :message_id
      t.integer :likes

      t.timestamps
    end
  end
end
