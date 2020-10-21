class TeamMailer < ApplicationMailer
  default from: 'codecircle13@gmail.com'

  def meeting_email(meeting, user)
    @meeting = meeting
    @user = user
    puts "********************** meeting email ******************"
    mail(to: "codecircle13@gmail.com", subject: "סיכום פגישה - ארכיון השומר הצעיר")
  end
end
