class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search, :intro, :intro2, :intro3]

  def index
    redirect_to intro_path unless cookies[:intro] == "true"
  end

  def search
    if user_signed_in?
      if current_user.admin?
        if params[:documents]
          @documents = Document.all
        elsif params[:meetings]
          @meetings = Meeting.all
        elsif params[:tag]
          puts "*******************tag**********************************"
          @documents = Document.tagged_with(params[:tag])
          @meetings = Meeting.tagged_with(params[:tag])
        else
          puts "********************else*********************************"
          @documents = Document.all
          @meetings = Meeting.all
        end
      else
        if params[:documents]
          @documents = Document.approved.commons
          @documents = @documents + Document.approved.internal if current_user.status == "internal"
          @documents = @documents + Document.approved.personal.where(user_id: current_user.id)
          @meetings = Meeting.commons
        elsif params[:meetings]
          @meetings = Meeting.commons
          @meetings = @meetings + Meeting.team.where(team_id: current_user.teams.ids)
        elsif params[:tag]
          @documents = Document.approved.commons.tagged_with(params[:tag])
          @documents = @documents + Document.approved.internal.tagged_with(params[:tag]) if current_user.status == "internal"
          @documents = @documents + Document.approved.personal.where(user_id: current_user.id).tagged_with(params[:tag])
          @meetings = Meeting.commons.tagged_with(params[:tag])
        else
          @documents = Document.approved.commons
          @documents = @documents + Document.approved.internal if current_user.status == "internal"
          @documents = @documents + Document.approved.personal.where(user_id: current_user.id)
          @meetings = Meeting.commons
          @meetings = @meetings + Meeting.team.where(team_id: current_user.teams.ids)
        end
      end
    else
      if params[:documents]
        @documents = Document.approved.commons
      elsif params[:meetings]
        @meetings = Meeting.commons
        elsif params[:tag]
          @documents = Document.approved.commons.tagged_with(params[:tag])
          @meetings = Meeting.commons.tagged_with(params[:tag])
      else
        @documents = Document.approved.commons
        @meetings = Meeting.commons
      end
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
      redirect_to search_path
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
  def delete_attachment
    # @attachment = ActiveStorage::Blob.find_signed(params[:a_id])
    @attachment =  ActiveStorage::Attachment.find(params[:a_id])
    puts "**************** ataachtmetn: #{@attachment.filename} ************************"
    @attachment.purge
    respond_to do |format|
      format.js
    end

  end

  def intro
    cookies[:intro] = "true"
  end

  def intro2
  end

  def intro3
  end

end
