# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'registrations', type: :request do
  describe 'GET /resource/sign_up' do
    it 'returns http success' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end
end
