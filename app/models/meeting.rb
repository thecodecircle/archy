class Meeting < ApplicationRecord
  belongs_to :team
  has_many_attached :attachments
  has_rich_text :content
end
