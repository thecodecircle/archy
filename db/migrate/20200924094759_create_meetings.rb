class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.references :team, null: false, foreign_key: true
      t.text :content
      t.integer :privacy

      t.timestamps
    end
  end
end
