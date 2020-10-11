class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  def index
  end

  def search
  end

  def pashi
  end

  def user_index
    @users = User.all
  end

  def toggle_status
    user = User.find(params[:clicked_user])
    user.status = 1 - user.read_attribute_before_type_cast(:status)
    user.save
    redirect_to user_index_path
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

end
