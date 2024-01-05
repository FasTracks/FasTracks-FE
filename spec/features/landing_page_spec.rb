require 'rails_helper'

RSpec.describe 'landing page' do
  describe 'Landing Page' do
    #US 1
    # -As a visitor, when I visit the landing page, I see a button to Connect to Spotify to Create a Playlist
    # -When you click on the button, it takes you to sign into your Spotify account
    # -Once you sign in, it redirects you to create a playlist page

    it 'has a app name and a button that requests Spotify access' do
      visit root_path

      expect(page).to have_content('FasTracks')
      expect(page).to have_button('Connect to Spotify to Create a Playlist')
    end

    it 'has a button for Spotify Authorization and Close when you click on Connect to Spotify to Create a Playlist' do
      visit root_path

      click_button('Connect to Spotify to Create a Playlist')

      within('.modal') do
        expect(page).to have_content('Spotify Authorization')
        expect(page).to have_content('Connect your Spotify account to access more features.')
        expect(page).to have_link('Authorize on Spotify')
        expect(page).to have_button('Close')
      end
    end

    it 'redirects you to log in to Spotify when you click on Authorize on Spotify', js: true do
      id = Rails.application.credentials.spotify[:user_id]
      pw = Rails.application.credentials.spotify[:password]
      visit root_path

      click_button('Connect to Spotify to Create a Playlist')

      within('.modal-body') do
        click_link('Authorize on Spotify')
      end

      fill_in('Email or username', with: id)
      fill_in('Password', with: pw)
      click_button('Log In')
      click_button('Agree')

      expect(current_path).to eq(callback_path)
    end
  end
end
