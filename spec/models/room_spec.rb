require 'rails_helper'

RSpec.describe Room, type: :model do

  context 'validation tests' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_fields(:title) }
    it {should validate_presence_of :title}
    it { is_expected.to embed_many(:messages)}

    it 'should save successfully'  do
      time_now = Time.now.to_i.to_s
      room = Room.new(title: 'Any Title '+time_now,).save
      expect(room).to eq(true)
    end
  end
end
