class ChangeDateTimeToDate < ActiveRecord::Migration[5.0]
  def change
  	change_column :tasks, :date,  :date
  end
end
