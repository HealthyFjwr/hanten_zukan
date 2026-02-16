# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::SearchRestaurants', type: :request do
  let(:admin) { create(:admin_user) }

  before do
    sign_in admin
  end

  it 'returns http success' do
    get admin_search_restaurants_path
    expect(response).to have_http_status(:ok)
  end
end
