class RemoveContentFromMeetings < ActiveRecord::Migration[6.0]
  def change
    remove_column :meetings, :content, :text
  end
end
