class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :documents
  has_and_belongs_to_many :teams, join_table: "teams_users"
  has_and_belongs_to_many :meetins, join_table: "meetings_users"
  enum status: [:not_approved, :approved]
  after_create :set_status

  validates :admin,  inclusion: { in: [true, false] }
  validates :status, inclusion: { in: User.statuses.keys }

  private
    def set_status
      if self.admin?
        self.approved!
      else
        self.not_approved!
      end
    end
end
