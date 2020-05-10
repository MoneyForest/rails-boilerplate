# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe 'callback twitter' do
    before do
      OmniAuth.config.mock_auth[:twitter] = twitter_mock
      visit new_user_registration_path
    end

    it 'crate a user' do
      expect { click_link 'Sign in with Twitter' }.to change(User, :count).by(1)
    end
  end

  describe 'callback facebook' do
    before do
      OmniAuth.config.mock_auth[:facebook] = facebook_mock
      visit new_user_registration_path
    end

    it 'crate a user' do
      expect { click_link 'Sign in with Facebook' }.to change(User, :count).by(1)
    end
  end

  describe 'callback google' do
    before do
      OmniAuth.config.mock_auth[:google] = google_mock
      visit new_user_registration_path
    end

    it 'crate a user' do
      expect { click_link 'Sign in with Google' }.to change(User, :count).by(1)
    end
  end

  describe 'user is persisted' do
    before do
      OmniAuth.config.mock_auth[:google] = google_mock
      visit new_user_registration_path
    end

    it 'not crate a user' do
      expect { click_link 'Sign in with Google' }.to change(User, :count).by(1)
      sign_out_user
      visit new_user_registration_path
      expect { click_link 'Sign in with Google' }.to change(User, :count).by(0)
    end
  end
end
