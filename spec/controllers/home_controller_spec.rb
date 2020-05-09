# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #home' do
    context 'current_user exists' do
      it 'returns http redirect' do
        sign_in_user
        get :home
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'current_user not exists' do
      it 'returns http success' do
        get :home
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #top' do
    context 'when logged in' do
      it 'returns http success' do
        sign_in_user
        get :top
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not logged in' do
      it 'returns http redirect' do
        get :top
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET #mypage' do
    context 'when logged in' do
      it 'returns http success' do
        sign_in_user
        get :mypage
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not logged in' do
      it 'returns http redirect' do
        get :mypage
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
