require "rails_helper"

describe PlaylistController, type: :controller do
  describe "#create" do
    before(:each) do
      json = File.read('spec/support/fixtures/fastracks/playlist.json')
      faraday_response = double('Faraday::Response', status: 200, body: json, success?: true)

      allow(FastracksBeService).to receive(:submit_playlist).and_return(faraday_response)
    end

    it "successfully sends playlist preferences to backend server" do
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
