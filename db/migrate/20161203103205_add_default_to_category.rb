class AddDefaultToCategory < ActiveRecord::Migration[5.0]
  def change
  	change_column :tasks, :category, :string, :default => "altro"
  end
end
