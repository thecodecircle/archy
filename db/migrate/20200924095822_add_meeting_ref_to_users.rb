class AddMeetingRefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :meeting, null: false, foreign_key: true
  end
end
