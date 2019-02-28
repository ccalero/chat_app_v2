require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    time_now = Time.now.to_i.to_s
    {
      username: 'username'+time_now
    }
  end

  context 'validation tests' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_fields(:username) }
    it {should validate_presence_of :username}

    # it { is_expected.to embed_many(:messages)}

    it {should validate_uniqueness_of(:username).case_insensitive}

    it 'should save successfully'  do
      user = User.new(valid_attributes).save
      expect(user).to eq(true)
    end
  end
end
