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
    it 'returns http success' do
      sign_in_user
      visit edit_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /resource' do
    it 'returns http success' do
      sign_in_user
      visit edit_user_registration_path
      expect(response).to have_http_status(:success)
      fill_in 'Email',                 with: 'fuga@example.com'
      fill_in 'Password',              with: 'bazqux'
      fill_in 'Password confirmation', with: 'bazqux'
      fill_in 'Current password', with: 'foobar'
      click_button 'Update'

      expect(URI.parse(current_url).path.to_s).to eq(top_path)
      expect(page).to have_text('You updated your account successfully, ' \
                                'but we need to verify your new email address')
    end
  end

  describe 'DELETE /resource', js: true do
    it 'returns http success' do
      sign_in_user

      expect(User.count).to eq(1)
      expect(WithdrawalUser.count).to eq(0)

      visit edit_user_registration_path
      expect(response).to have_http_status(:success)
      click_button 'Cancel my account'
      page.accept_confirm 'Are you sure?'
      sleep 0.5
      expect(User.count).to eq(0)
      expect(WithdrawalUser.count).to eq(1)
      expect(URI.parse(current_url).path.to_s).to eq(root_path)
      expect(page).to have_text('Bye! Your account has been successfully ' \
                                'cancelled. We hope to see you again soon.')
    end
  end
end
