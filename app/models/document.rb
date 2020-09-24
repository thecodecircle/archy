class Document < ApplicationRecord
  belongs_to :user
  has_many_attached :attachments
  has_rich_text :content
  has_rich_text :description
  enum privacy: [
    :personal,
    :commons
  ]
end
