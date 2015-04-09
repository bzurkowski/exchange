class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer  :subject_id
      t.integer  :instructor_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.string   :description

      t.timestamps null: false
    end

    add_index :terms, :subject_id
    add_index :terms, :instructor_id
    add_index :terms, [:starts_at, :subject_id, :instructor_id], unique: true
  end
end
