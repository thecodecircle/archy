class AddPrivacyToDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :privacy, :integer
  end
end
