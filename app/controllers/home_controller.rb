class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search, :intro, :intro2, :intro3]

  def index
    redirect_to intro_path unless cookies[:intro] == "true"
  end

  def search
    if user_signed_in?
      if current_user.admin?
        if params[:approving]
          @documents = Document.not_approved
        else
          @documents = Document.approved
          @meetings = Meeting.all
        end
      else
        @documents = Document.approved.commons
        @documents = @documents + Document.approved.internal if current_user.status == "internal"
        @documents = @documents + Document.approved.personal.where(user_id: current_user.id)
        @meetings = Meeting.commons
        @meetings = @meetings + Meeting.team.where(team_id: current_user.teams.ids)
      end
    else
      @documents = Document.approved.commons
      @meetings = Meeting.commons
    end
  end

  def user_index
    @users = User.all
  end

  def toggle_status
    if params[:clicked_user]
      user = User.find(params[:clicked_user])
      user.status = 1 - user.read_attribute_before_type_cast(:status)
      user.save
      redirect_to user_index_path
    elsif params[:clicked_document]
      document = Document.find(params[:clicked_document])
      document.status = 1 - document.read_attribute_before_type_cast(:status)
      document.save
      redirect_to search_path(approving: true)
    end
  end

  def toggle_admin
    user = User.find(params[:clicked_user])
    if user.admin?
      user.admin = false
    else
      user.admin = true
    end
    user.save
    redirect_to user_index_path
  end

  def destroy_user
    user = User.find(params[:clicked_user])
    user.destroy
    redirect_to user_index_path
  end

  def profile
    @user = current_user
    @documents = @user.documents
    @meetings = @user.meetings
  end

  def intro
    cookies[:intro] = "true"
  end

  def intro2
  end

  def intro3
  end

end
