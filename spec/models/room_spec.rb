require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:valid_attributes) do
    time_now = Time.now.to_i.to_s
    {
      title: 'Any Title'+time_now,
    }
  end

  context 'validation tests' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_fields(:title) }
    it {should validate_presence_of :title}
    it { is_expected.to embed_many(:messages)}

    it 'should save successfully'  do
      room = Room.new(valid_attributes).save
      expect(room).to eq(true)
    end
  end
end
