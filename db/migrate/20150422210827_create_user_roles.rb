class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :user, index: true
      t.references :role, index: true
    end
    add_foreign_key :user_roles, :users
  end
end
