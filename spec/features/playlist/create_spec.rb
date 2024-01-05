require "rails_helper"

describe PlaylistController, type: :controller do
  describe "#create" do
    before(:each) do
      allow(FastracksBeService).to receive(:submit_playlist).and_return({status: 200})
    end

    it "successfully sends playlist preferences to backend server" do
      params = {
        token: "fakeToken",
        genre: "EDM",
        workout: "HIIT"
      }
      post :create, params: params

      expect(response).to have_http_status(:ok)
    end
  end
end
