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
end
