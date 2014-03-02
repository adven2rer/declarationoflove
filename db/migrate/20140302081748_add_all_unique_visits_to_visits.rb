class AddAllUniqueVisitsToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :all_unique_visits, :integer
  end
end
