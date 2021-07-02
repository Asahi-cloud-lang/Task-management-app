class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :work
      t.string :detail
      t.integer :user_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
