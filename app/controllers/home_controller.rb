class HomeController < ApplicationController
  def home
      redirect_to top_path if current_user
  end

  def top
      redirect_to root_path unless current_user
  end
end
