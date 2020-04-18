class HomeController < ApplicationController
  def home
      render 'home/top' if current_user
  end

  def top
  end
end
