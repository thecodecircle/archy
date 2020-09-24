class Meeting < ApplicationRecord
  belongs_to :team
  has_and_belongs_to_many :users, join_table: "meetings_users"
  has_many_attached :attachments
  has_rich_text :content
  enum privacy: [
    :personal,
    :team,
    :commons
  ]
end
