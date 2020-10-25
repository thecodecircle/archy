class TeamMailer < ApplicationMailer
  default from: 'codecircle13@gmail.com'

  def meeting_email(meeting, user)
    @meeting = meeting
    @user = user
    @meeting.attachments.each do |file|
      attachments[file.blob.filename.to_s] = {
        mime_type: file.blob.content_type,
        content: file.blob.download
      }
    end
    mail(to: @meeting.team.users.pluck(:email), subject: "סיכום פגישה של #{@meeting.team.name} - ארכיון השומר הצעיר")
  end

  def notify_registration(user)
    @user = user
    mail(to: User.where(admin: true).pluck(:email), subject: "רישום חדש לארכיון השומר הצעיר - #{user.name}")
  end

  def notify_document(user)
    @user = user
    mail(to: User.where(admin: true).pluck(:email), subject: "מסמך חדש בארכיון השומר הצעיר - #{user.name}")
  end
end
