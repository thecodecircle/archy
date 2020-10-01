class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  def index
  end

  def search
  end

end
