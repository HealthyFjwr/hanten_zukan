# frozen_string_literal: true

require "rails_helper"

RSpec.describe Restaurant, type: :model do
  it "factoryが有効" do
    expect(build(:restaurant)).to be_valid
  end

  it "place_idはユニーク" do
    create(:restaurant, place_id: "abc")
    dup = build(:restaurant, place_id: "abc")
    expect(dup).not_to be_valid
  end

  it "nameが空だと無効" do
    r = build(:restaurant, name: "")
    expect(r).not_to be_valid
  end

  it "latitude/longitudeがnilだと無効" do
    r = build(:restaurant, latitude: nil, longitude: nil)
    expect(r).not_to be_valid
  end
end
