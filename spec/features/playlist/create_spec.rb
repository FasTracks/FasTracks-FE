require "rails_helper"

describe PlaylistController, type: :controller do
  describe "#create" do
    before(:each) do
      json = File.read('spec/support/fixtures/fastracks/playlist.json')
      response = JSON.parse(json, symbolize_names: true)
      allow(FastracksBeService).to receive(:submit_playlist).and_return({status: 200, body: response, headers: {}})
    end

    xit "successfully sends playlist preferences to backend server" do
      params = {
        token: "fakeToken",
        genre: "EDM",
        workout: "HIIT"
      }
      post :create, params: params
      expect(response).to have_http_status(:found)
    end
  end
end
