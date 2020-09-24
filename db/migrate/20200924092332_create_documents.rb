class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.text :description

      t.timestamps
    end
  end
end
