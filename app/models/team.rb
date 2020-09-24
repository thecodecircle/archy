class Team < ApplicationRecord
  has_and_belongs_to_many :users, join_table: "teams_users"
  has_many :meetings
end
