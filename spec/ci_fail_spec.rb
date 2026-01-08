RSpec.describe "CI fail check" do
  it "fails intentionally" do
    expect(1).to eq(2)
  end
end
