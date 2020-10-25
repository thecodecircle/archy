class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :documents
  has_and_belongs_to_many :teams, join_table: "teams_users"
  has_and_belongs_to_many :meetings, join_table: "meetings_users"
  enum status: [:regular, :internal]
  after_create :set_status
  acts_as_taggable_on :achievements

  validates :admin,  inclusion: { in: [true, false] }
  # validates :status, inclusion: { in: User.statuses.keys }

  private
    def set_status
      if self.admin?
        self.internal!
      else
        self.regular!
        TeamMailer.notify_registration(self).deliver_now
      end
    end
end
