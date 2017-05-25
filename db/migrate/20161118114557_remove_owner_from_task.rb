class RemoveOwnerFromTask < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :owner, :string
  end
end
