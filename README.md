# FasTracks README
FasTracks provides a streamlined approach to workout playlist generation. Once the user selects genre preference and workout type, they are provided with an optimized playlist using metadata from Spotify, and criteria held in the FasTracks backend.

The project follows service-oriented architecture (SOA) and is divided into two different repositories:
  - [FasTracks-Frontend](https://github.com/FasTracks/FasTracks-FE) (you are here)
  - [FasTracks-Backend](https://github.com/FasTracks/FasTracks-BE)

This application is deployed using heroku, and is available to select users [here](https://fastracks-62267ab898ea.herokuapp.com/) 


# FasTracks-FE

FasTracks-FE uses Bootstraps as a CSS framework to aid with responsiveness to enable mobile view. HTML is also used.   

FasTracks-FE is responsible for user authentication via OAuth 2.0. FasTracks-FE requests the user authorize access to specific Spotify endpoints. Once the user grants access, FasTracks-FE recieves an access token to make API calls to Spotify on behalf of the user. FasTracks-FE requests and caches available genre seeds from Spotify, and presents the user with a selection of over 50 genres and 5 workouts. Once the user clicks `generate playlist`, a POST request is sent to FasTracks-BE. FasTracks-FE recieves a JSON response that includes all the important playlist details, as well as a link to the playlist within the user's Spotify account. The playlist details are rendered in a mobile-friendly view, showing the user track order, album artwork, track name and artist name. A button is rendered to link the user to the playlist within their Spotify. Within a few seconds, the user is able to create a unique playlist and start their workout. 

## Getting Started

The fastest way to start working out using FasTracks is to visit our deployed app [here](https://fastracks-62267ab898ea.herokuapp.com/).

If you would like to run the application locally, you will need Rails 7.X.X and to clone both [FasTracks-FE](https://github.com/FasTracks/FasTracks-FE) and [FasTracks-BE](https://github.com/FasTracks/FasTracks-BE), since the application follows service-oriented architecture. Within each repo, follow the steps below. 

1. `bundle install`
2. `rails db:{drop,create}` note: no data is stored in the db but required for server spin up
3. `rails dev:cache` -- enables caching in dev environment
4. `bundle exec rspec` -- to see results of TDD
5. update .env file 
   1. place your callback uri in the appropriate variable (localhost:5000 if running locally, else the hosted url)
6. `rails server`

Then, in your browser, visit `localhost:5000` and follow the prompts on screen.

*Due to development constraints from Spotify, FasTracks is currently limited to invite-only users. Please message one of our contributors with to be added to our list of approved users. Please be sure to include the email address associated with your Spotify account. Alternatively, users may create their own app through [Spotify's developer portal](https://developer.spotify.com/documentation/web-api/concepts/apps) and reconfigure the Client ID and Client Secret in their local copy of the FE repo `rails credentials:edit`.  Don't forget to add the appropriate callback uris in your Spotify's App*


### Prerequisites

For the fastest startup, we recommend visiting the deployed app [here](https://fastracks-62267ab898ea.herokuapp.com/).

However, if you prefer to get your hands dirty and understand our app, feel free to fork and clone this repo as well as [FasTracks-BE](https://github.com/FasTracks/FasTracks-BE). We recommend a basic understanding of the following concepts before diving in to our code:

- Ruby on Rails Applications
- Service oriented architecture
- Oauth 2.0
- Spotify API

### Notes on Data Flow

1.  FasTracks-FE authorizes the user on Spotify and recieves an Auth Token, for the following scopes on Spotify:
   - `playlist-modify-public playlist-modify-private`
2.  A user access token is requested from Spotify after obtaining an authorization token. This is a sequential process that is kicked off once the user hits the callback controller action.
3.  Once the user selects the playlist preferences (genre, workout type, etc.), that data will be sent to the backend service via query params:
   -  `HTTP://<backendurl/path>?code=<USER_ACCESS_TOKEN>&genre=<SELECTED_GENRE>&workout=<SELECTED_WORKOUT>`
4.  The expected response from the backend server should be a JSON body response with status code `200`
    ```json 
    {
      "status": 200,
      "data": {
                "collaborative": false,
                "description": "A playlist for testing pourposes",
                "external_urls": {
                    "spotify": "https://open.spotify.com/playlist/3cEYpjA9oz9GiPac4AsH4n"
                },...
    }
      ```
  5. FasTracks-FE renders the playlist data in a mobile-friendly view, with a button to the new playlist on Spotify.
  6. Requesting an Access Token:

```bash
curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -H "Authorization: Basic <base64 encoded client_id:client_secret>" \
     -d "grant_type=client_credentials&code=<code returned from the auth request>&redirect_uri<matching URI>"
```

### Installing

Ensure to install gems; this project uses bootstrap for mobile first design

`bundle install`<br>
`rails db:{create,migrate}`<br>
`rails dev:cache`<br>
update .env file

## Running the tests 

Follow commands below to run the app test suite. 

`bundle exec rspec`

### Sample Tests

The test below is within the `spec/features/landing_page_spec.rb` file, and is used to test the view contents and formatting on our app's landing page. The following items are considered within the test:

- The app name
- A button to connect to Spotify
- The correct link for spotify authorization
- A button to close the modal.

These are essential features to test because the user would simply not be able to use the app without them. 

```ruby
    describe "Landing Page" do
    # US 1
    # - As a visitor, when I visit the landing page, I see a button to Connect to Spotify to Create a Playlist
    # - When you click on the button, it takes you to sign into your Spotify account
    # - Once you sign in, it redirects you to create a playlist page

    it "has an app name and a button that requests Spotify access" do
      visit root_path

      expect(page).to have_content("FasTracks")
      expect(page).to have_button("Connect to Spotify to Create a Playlist")
    end

    it "has a button for Spotify Authorization and closes when you click on Connect to Spotify to Create a Playlist" do
      visit root_path

      click_button("Connect to Spotify to Create a Playlist")

      within(".modal") do
        expect(page).to have_content("Spotify Authorization")
        expect(page).to have_content("Connect your Spotify account to access more features.")
        expected_href = "https://accounts.spotify.com/authorize?client_id=#{Rails.application.credentials.spotify[:client_id]}&response_type=code&redirect_uri=http://localhost/callback&scope=playlist-modify-private%20playlist-modify-public"
        expect(page).to have_link("Authorize on Spotify", href: expected_href)
        expect(page).to have_button("Close")
      end
    end
  end
```

## FasTracks Screenshots
### Mobile view:

[![FasTracks Mobile View](https://img.youtube.com/vi/mR6c5VnBfA8/0.jpg)](https://www.youtube.com/watch?v=mR6c5VnBfA8)

### Desktop view:

#### Landing page:
<img width="714" alt="image" src="https://github.com/FasTracks/FasTracks-FE/assets/138252060/e72fef45-2c1c-4658-87c5-1d52ab68e5cf">

<img width="714" alt="image" src="https://github.com/FasTracks/FasTracks-FE/assets/138252060/d0df3ffc-4bfd-4539-87da-8a546b1059a8">

<img width="714" alt="image" src="https://github.com/FasTracks/FasTracks-FE/assets/138252060/c475a109-b149-4da7-b1eb-99a9bb5a213e">

#### Generate playlist:

<img width="714" alt="image" src="https://github.com/FasTracks/FasTracks-FE/assets/138252060/76cd2caa-bd56-4ca5-b58b-8346b32e5c3e">

<img width="714" alt="image" src="https://github.com/FasTracks/FasTracks-FE/assets/138252060/961e8eaa-da35-43dc-9f5a-1521b62522a0">

#### Playlist show page:

<img width="714" alt="image" src="https://github.com/FasTracks/FasTracks-FE/assets/138252060/cf08e622-d2f4-49a3-b07a-5f74e8d2e424">

## Deployment

This project is deployed using heroku [here](https://fastracks-62267ab898ea.herokuapp.com/) 
  
<img src="https://logowik.com/content/uploads/images/heroku8748.jpg" alt="drawing" width="100"/>

## Built With 

- Spotify API
- Ruby on Rails
- Bootstrap
- Faraday
- Capybara
- Webmock

<img src="https://mikewilliamson.files.wordpress.com/2010/05/rails_on_ruby.jpg" alt="drawing" width="75"/>
<img src="https://codekitapp.com/images/help/free-bootstrap-icon@2x.png" alt="drawing" width="75"/>
<img src="https://storage.googleapis.com/pr-newsroom-wp/1/2018/11/Spotify_Logo_CMYK_Green.png" width="75"/>

## Contributing 

Contributions are welcome and can be submitted by pull request. 

## Versioning 

The current version (V1) of our application is live here on github.

## Authors

  - **Edward Avery Rodriguez** - *[LinkedIn](https://www.linkedin.com/in/edward-avery-rodriguez/), [GitHub](https://github.com/TheAveryRodriguez)* 
  - **Kameron Kennedy** - *[LinkedIn](https://www.linkedin.com/in/kameron-kennedy-pe/), [GitHub](https://github.com/kameronk92)* 
  - **Scott DeVoss** - *[LinkedIn](https://www.linkedin.com/in/scott-devoss/), [GitHub](https://github.com/scottdevoss)* 
  - **Sooyung Kim** - *[LinkedIn](https://www.linkedin.com/in/sooyung-kim/), [GitHub](https://github.com/skim1027)* 
  - **Taylor Pubins** - *[LinkedIn](https://www.linkedin.com/in/trpubins/), [GitHub](https://github.com/trpubz)* 

## License 

This project is not licensed and is open source. 

## Acknowledgments 

  - Technical direction and consultation provded by [Jamison Ordway](https://github.com/jamisonordway) and [Chris Simmons](https://github.com/cjsim89)
  - This project completed by Mod 3 students at [Turing School of Software and Design](https://turing.edu/)
  - Little Caesar's Pizza for providing the most calories per dollar within 0.5 miles of [kameronk92's](https://github.com/kameronk92) house
