require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      room = Room.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      room = Room.create! valid_attributes
      get :show, params: {id: room.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Room" do
        expect {
          post :create, params: {room: valid_attributes}, session: valid_session
        }.to change(Room, :count).by(1)
      end

      it "renders a JSON response with the new room" do

        post :create, params: {room: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(room_url(Room.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new room" do

        post :create, params: {room: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

end
