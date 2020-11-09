class Team < ApplicationRecord
  has_and_belongs_to_many :users, join_table: "teams_users"
  has_many :meetings, dependent: :destroy
  acts_as_taggable_on :tags

  validates :name, presence: true
end
