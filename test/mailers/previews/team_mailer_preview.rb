# Preview all emails at http://localhost:3000/rails/mailers/team_mailer
class TeamMailerPreview < ActionMailer::Preview
  def meeting_email
    TeamMailer.meeting_email(Meeting.last, User.last)
  end
end
