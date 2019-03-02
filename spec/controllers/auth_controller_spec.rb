require 'rails_helper'

RSpec.describe AuthController, type: :controller do

  let(:valid_attributes) do
    time_now = Time.now.to_i.to_s
    { username: "AnyUser"+time_now }
  end

  let(:unvalid_attributes) do
    { username: "" }
  end

  describe "POST #signup" do
    it "User create OK" do
      post :signup, params: valid_attributes
      expect(response).to have_http_status(:success)
    end
    it "User invalid" do
      post :signup, params: unvalid_attributes
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "User already exist" do
      post :signup, params: valid_attributes
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST #login" do
    it "User login OK" do
      post :login, params: valid_attributes
      expect(response).to have_http_status(:success)
    end

    it "User invalid" do
      post :login, params: unvalid_attributes
      expect(response).to have_http_status(:not_found)
    end
  end

end
