class HomeController < ApplicationController
  def home
    redirect_to top_path if current_user
  end

  def top
  end

  def mypage
  end
end
