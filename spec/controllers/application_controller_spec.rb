# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render body: nil
    end
  end

  describe 'GET #some_acton' do
    context 'when signed in' do
      it 'returns http success' do
        sign_in_user
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not signed in' do
      it 'returns http redirect' do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
