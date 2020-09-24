class AddSubjectToMeeting < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :subject, :string
  end
end
