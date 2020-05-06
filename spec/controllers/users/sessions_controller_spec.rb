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
    before do
      user = create(:user)
      user.skip_confirmation!
      user.save!
    end
    it 'sign in' do
      visit new_user_session_path
      expect(response).to have_http_status(:success)
      fill_in 'Email',                 with: 'hoge@example.com'
      fill_in 'Password',              with: 'foobar'
      click_button 'Log in'
      expect(URI.parse(current_url).path.to_s).to eq(top_path)
      expect(page).to have_text('Signed in successfully.')
    end
  end

  describe 'DELETE /resource/sign_out' do
    before do
      user = create(:user)
      user.skip_confirmation!
      user.save!
    end
    it 'sign out' do
      visit new_user_session_path
      expect(response).to have_http_status(:success)
      fill_in 'Email',                 with: 'hoge@example.com'
      fill_in 'Password',              with: 'foobar'
      click_button 'Log in'
      expect(URI.parse(current_url).path.to_s).to eq(top_path)
      expect(page).to have_text('Signed in successfully.')

      page.driver.submit :delete, destroy_user_session_path, {}
      expect(URI.parse(current_url).path.to_s).to eq(root_path)
      expect(page).to have_text('Signed out successfully.')
    end
  end
end
