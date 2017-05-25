class RemoveTaskIdFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :task_id, :string
  end
end
