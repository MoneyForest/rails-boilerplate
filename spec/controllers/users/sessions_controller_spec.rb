# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'GET /resource/sign_in' do
    it 'returns http success' do
      visit new_user_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /resource/sign_in' do
    it 'sign in' do
      sign_in_user
    end
  end

  describe 'DELETE /resource/sign_out' do
    it 'sign out' do
      sign_in_user
      page.driver.submit :delete, destroy_user_session_path, {}
      expect(URI.parse(current_url).path.to_s).to eq(root_path)
      expect(page).to have_text('Signed out successfully.')
    end
  end
end
