class TeamMailer < ApplicationMailer
  default from: 'codecircle13@gmail.com'

  def meeting_email(meeting, user)
    @meeting = meeting
    @user = user
    puts "********************** meeting email ******************"
    mail(to: @meeting.team.users, subject: "סיכום פגישה של #{@meeting.team.name} - ארכיון השומר הצעיר")
  end
end
