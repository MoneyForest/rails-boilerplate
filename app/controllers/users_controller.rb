# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def update
    if @user.update_attributes(update_params)
      redirect_to root_path, notice: '更新しました'
    else
      redirect_back(fallback_location: edit_user_path, flash: {
                      error_messages: @user.errors.full_messages
                    })
    end
  end

  def show; end

  def edit; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def update_params
    params.require(:user).permit(:display_name,
                                 :icon_image,
                                 :background_image,
                                 :profile,
                                 :name,
                                 :birthday,
                                 :gender,
                                 :zip_code,
                                 :address,
                                 :job)
  end
end
