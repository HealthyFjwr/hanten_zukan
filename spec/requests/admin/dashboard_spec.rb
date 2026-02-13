# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Dashboards', type: :request do
  describe 'GET /index' do
    context '未ログイン' do
      it 'returns http success' do
        get '/admin'
        expect(response).to have_http_status(:found)
      end
    end

    context 'ログイン済み' do
      let(:admin) { create(:admin_user) }

      it 'HTTP response 200' do
        sign_in admin
        get '/admin'
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
