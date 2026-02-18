# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it 'factoryが有効' do
    expect(build(:admin_user)).to be_valid
  end

  it 'emailはユニーク' do
    create(:admin_user, email: 'a@example.com')
    dup = build(:admin_user, email: 'a@example.com')
    expect(dup).not_to be_valid
  end
end
