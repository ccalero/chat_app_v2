require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:valid_attributes) do
    {
      content: 'Any Content',
      sender_user: "any_user",
      room: Room.new(title: 'room1'),
    }
  end
  context 'validation tests' do
    it {should validate_presence_of :content}
    # it {should validate_presence_of :created_at}
    it {should validate_presence_of :sender_user}
    it {is_expected.to be_embedded_in :room}
    # it {is_expected.to be_embedded_in :user}

    it 'should save successfully'  do
      message = Message.new(valid_attributes).save
      expect(message).to eq(true)
    end
  end
end
