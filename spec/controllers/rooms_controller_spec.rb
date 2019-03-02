require 'rails_helper'

RSpec.describe Api::V1::RoomsController, type: :controller do

  let(:valid_attributes) do
    time_now = Time.now.to_i.to_s
    { title: "Any Title"+time_now }
  end

  let(:unvalid_attributes) do
    { title: "" }
  end

  context 'GET #index' do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    # it 'returns a redirect login page (not logging)' do
    # end

    # it "JSON body response contains expected recipe attributes" do
    #   json_response = JSON.parse(response.body)
    #   expect(json_response.map).to match_array([:_id, :messages, :title])
    # end

  end

  context 'POST #create' do

    it "Create Room Valid" do
      post :create, params: {room: valid_attributes}
      expect(response).to have_http_status(:created)
    end

    it "Create Room invalid" do
      post :create, params: {room: unvalid_attributes}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    # it 'returns a redirect login page (not logging)' do
    # end

    # it "JSON body response contains expected recipe attributes" do
    #   json_response = JSON.parse(response.body)
    #   expect(json_response.map).to match_array([:messages, :room])
    # end

  end

  context 'GET #show' do
    before do
      room = Room.find_by(valid_attributes)
      get :show, params: { id: room.to_param }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    # it 'returns a redirect login page (not logging)' do
    # end

    # it "JSON body response contains expected recipe attributes" do
    #   json_response = JSON.parse(response.body)
    #   expect(json_response.map).to match_array([:messages, :room])
    # end
  end

  # context 'GET #show' do
  #   it 'returns a redirect login page (not logging)' do
  #     room = Room.create!(valid_attributes)
  #     get :show, params: { id: room.to_param }
  #     expect(response).to redirect_to root_path
  #   end
  #   it 'returns a success response' do
  #     log_user
  #     room = Room.create!(valid_attributes)
  #     get :show, params: { id: room.to_param }
  #     expect(response).to be_success # response.success?
  #   end
  # end
  #
  # context 'POST #create' do
  #   it 'returns a redirect login page (not logging)' do
  #     post :create, params: {'room': valid_attributes}
  #     expect(response).to redirect_to root_path
  #   end
  # end
end
