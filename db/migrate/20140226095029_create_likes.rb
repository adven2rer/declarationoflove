class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :karma
      t.integer :message_id

      t.timestamps
    end
      add_index :likes, [:message_id]
  end
end
