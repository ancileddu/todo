class AddDateStartAndDateEndToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :startDate, :timestamp
    add_column :tasks, :endDate, :timestamp
  end
end
