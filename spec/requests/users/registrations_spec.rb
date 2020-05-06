# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'registrations', type: :request do
  describe 'GET /resource/sign_up' do
    it 'returns http success' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /resource' do
    let(:user) { create(:user) }

    it 'returns http success' do
      expect { post user_registration_path }.to change(User, :count).by(1)
    end
  end
end
