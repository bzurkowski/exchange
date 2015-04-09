class CreateAssignations < ActiveRecord::Migration
  def change
    create_table :assignations do |t|
      t.integer :schedule_id
      t.integer :term_id

      t.timestamps null: false
    end

    add_index :assignations, :schedule_id
    add_index :assignations, :term_id
  end
end
