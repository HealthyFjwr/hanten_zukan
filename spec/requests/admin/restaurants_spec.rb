# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Restaurants', type: :request do
  describe 'GET /admin/restaurants' do
    context '未ログイン' do
      it 'ログイン画面にリダイレクトされる' do
        get '/admin/restaurants'
        expect(response).to have_http_status(:found) # 302
      end
    end

    context 'ログイン済み' do
      let(:admin) { create(:admin) }

      it '200で表示される' do
        sign_in admin
        get '/admin/restaurants'
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
