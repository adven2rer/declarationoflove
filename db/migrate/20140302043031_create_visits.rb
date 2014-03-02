class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :all_not_unique_visits

      t.timestamps
    end
  end
end
