require 'rails_helper'

describe 'spotify facade' do
  it 'exist' do
    service = SpotifyFacade.access_token('fake_token')

    
    expect(service).to eq()
  end
end