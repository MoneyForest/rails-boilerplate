# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET /resource/edit' do
    it 'is success user update' do
      sign_in_user
      click_link 'edit'
      expect(response).to have_http_status(:success)
      click_button 'confirm'

      expect(page).to have_text('更新しました')
      expect(URI.parse(current_url).path.to_s).to eq(top_path)
    end

    it 'is failure user update' do
      sign_in_user
      click_link 'edit'
      expect(response).to have_http_status(:success)
      fill_in 'Display name', with: 'morethan15characters'
      click_button 'confirm'

      expect(page).to have_text('Display name is too long (maximum is 15 characters)')
    end
  end
end
