class AddDateToDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :date, :date
  end
end
