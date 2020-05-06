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
      before do
        allow(controller).to receive(:authenticate_user!).and_return true
      end

      it 'returns http success' do
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
