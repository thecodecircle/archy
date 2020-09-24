class RemoveColumnsFromDocuments < ActiveRecord::Migration[6.0]
  def change
    remove_column :documents, :content, :text
    remove_column :documents, :description, :text
  end
end
