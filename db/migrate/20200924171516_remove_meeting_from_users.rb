class RemoveMeetingFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :meeting, null: false, foreign_key: true
  end
end
