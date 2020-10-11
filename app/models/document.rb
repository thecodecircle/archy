class Document < ApplicationRecord
  belongs_to :user
  has_many_attached :attachments
  has_rich_text :content
  has_rich_text :description
  enum privacy: [:personal, :internal, :commons]
  enum status: [:not_approved, :approved]
  acts_as_taggable_on :tags

  # include PgSearch::Model
  # multisearchable against: :title

  validates :title,  presence: true
  validates :privacy, inclusion: { in: Document.privacies.keys }
end
