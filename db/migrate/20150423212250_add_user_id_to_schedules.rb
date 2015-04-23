class AddUserIdToSchedules < ActiveRecord::Migration
  def change
    add_reference   :schedules, :user, index: true
    add_foreign_key :schedules, :users
  end
end
