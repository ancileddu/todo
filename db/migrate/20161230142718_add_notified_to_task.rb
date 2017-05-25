class AddNotifiedToTask < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :notified, :boolean, :default => false
  end
end
