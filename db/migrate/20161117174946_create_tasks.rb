class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :owner
      t.string :value
      t.boolean :completed
      t.string :category
      t.datetime :date
      t.string :assignee

      t.timestamps
    end
  end
end
