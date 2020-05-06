# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Users::RegistrationsController, type: :controller do
  describe 'GET /resource/sign_up' do
    it 'returns http success' do
      visit new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /resource' do
    it 'returns http success' do
      visit new_user_registration_path
      expect(response).to have_http_status(:success)
      fill_in 'Email',                 with: 'hoge@example.com'
      fill_in 'Password',              with: 'foobar'
      fill_in 'Password confirmation', with: 'foobar'
      expect { click_button 'Sign up' }.to change(User, :count).by(1)
      expect(response).to have_http_status(:success)

      expect(URI.parse(current_url).path.to_s).to eq(root_path)
      expect(page).to have_text('A message with a confirmation link has been sent to your email address. ' \
                                'Please follow the link to activate your account.')
    end
  end

  describe 'GET /resource/edit' do
    before do
      user = create(:user)
      user.skip_confirmation!
      user.save!
    end
    it 'returns http success' do
      visit new_user_session_path
      expect(response).to have_http_status(:success)
      fill_in 'Email',                 with: 'hoge@example.com'
      fill_in 'Password',              with: 'foobar'
      click_button 'Log in'
      expect(URI.parse(current_url).path.to_s).to eq(top_path)
      expect(page).to have_text('Signed in successfully.')

      visit edit_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end
end
