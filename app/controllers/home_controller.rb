class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  def index
  end

  def search
    @documents = Document.all
    @meetings = Meeting.all
  end

  def pashi
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
  end

end
