require 'rails_helper'

RSpec.describe Place, type: :model do

  let(:user) { create(:user) }
  let(:place) { create(:place, user_id: user.id) }
  let(:location) { build(:location, place_id: place.id) }

  it "has a valid factory" do
    expect(place).to be_valid
  end

  describe "ActiveModel validations" do
    it { expect(place).to validate_presence_of(:name) }
    it { expect(place).to allow_value([]).for(:shared_with) }
  end

  describe "ActiveRecord associations" do
    it { expect(place).to belong_to(:user) }
    it { expect(place).to have_one(:location) }
    it { expect(place).to accept_nested_attributes_for(:location) }
  end

  describe "ActiveRecord Scopes" do
    it ".publicly_shared returns all places shared publicly" do
      user1 = create(:user)
      place1 = create(:place, user_id: user1.id)
      place2 = create(:place, user_id: user1.id, shared_with: [create(:user).id])
      expect(Place.publicly_shared).to eq([place1])
    end

    it ".shared_with_me returns all places shared with specific user" do
      user1 = create(:user)
      user2 = create(:user)
      place1 = create(:place, user_id: user1.id)
      place2 = create(:place, user_id: user1.id, shared_with: [user2.id])
      expect(Place.shared_with_me(user2.id)).to eq([place2])
    end
  end

  context "callbacks" do
    let(:user) { create(:user) }
    let(:place) { create(:place, user_id: user.id) }

    it 'fires set_uuid method as after_create callbacks' do
      expect(place).to receive(:set_uuid)
      place.run_callbacks(:create)
    end
    it { expect(place.uuid).to_not eq(nil) }
  end

end
