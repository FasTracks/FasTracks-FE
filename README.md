# FasTracks 
FasTracks provides a streamlined approach to workout playlist generation after answering simple questions such as genre preference and workout type.  A playlist is optimized based on bpm, danceability, and similar metadata based on user preference.

The project is following service-oriented architecture (SOA) and is divided into two different repository:
  - [FasTracks-Frontend](https://github.com/FasTracks/FasTracks-FE)
  - [FasTracks-Backend](https://github.com/FasTracks/FasTracks-BE)

This project is deployed using `fill in the blank`. 
  - [FasTracks-Frontend]()
  - [FasTracks-Backend]()

# FasTracks-FE

The frontend application is build using HTML and CSS. This application utilizes Bootstraps as a CSS framework to aid with responsiveness to enable mobile view.  

It also is responsible for authentication via OAuth 2.0. FasTracks-FE requests access to Spotify through the end user, which once the end user grants access, FasTracks is able to create an access token to make a playlist with genre and workout type that the end user selected.  This information is sent to the FasTracks-BE where it handles the API call for genre search and playlist creation using the access token.

## Getting Started

As the FasTracks application is SOA, in order to run the app, both repository will need to be cloned and running in local using localhost:3000 and localhost:5000.

  - [FasTracks-Frontend](https://github.com/FasTracks/FasTracks-FE)
  - [Backend-Backend](https://github.com/FasTracks/FasTracks-BE)

### Prerequisites

In order to utilize this app, the user will need to create an app to receive a client ID and client secret through Spotify developer.

  - [Spotify API Credentials](https://developer.spotify.com/documentation/web-api/concepts/apps)
    - Familiarity with OAuth2.0 authorization

### Notes on Data Flow
This front end portion will conduct OAuth authorization and then pass the data to the backend service responsible for playlist generation.

1.  The front end will authorize for the Spotify user using the following scopes:
   - `playlist-modify-public playlist-modify-private`
2.  A user access token will be requested after obtaining an authorization token
   -  This is a background task that will be kicked off once landed on the callback page
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

### Installing

Ensure to install gems; this project uses bootstrap for mobile first design

`bundle install`<br>
`rails db:{create,migrate}`<br>
`rails dev:cache`

## Running the tests `Need to figure out what test to include`

Explain how to run the automated tests for this system

### Sample Tests

Explain what these tests test and why

    Give an example

### Style test

Checks if the best practices and the right coding style has been used.

    Give an example

## Screenshots of final product
### Mobile view:


### Desktop view:
#### Landing page:


#### Generate playlist:


#### Playlist show page:


## Deployment

This project is deployed using `fill in remove heroko if not used`<br >
  - [FasTracks-Frontend]()
  - [FasTracks-Backend]()
  
<img src="https://logowik.com/content/uploads/images/heroku8748.jpg" alt="drawing" width="100"/>

## Built With `Add gems`

<img src="https://mikewilliamson.files.wordpress.com/2010/05/rails_on_ruby.jpg" alt="drawing" width="75"/>
<img src="https://codekitapp.com/images/help/free-bootstrap-icon@2x.png" alt="drawing" width="100"/>
<img src="https://storage.googleapis.com/pr-newsroom-wp/1/2018/11/Spotify_Logo_CMYK_Green.png" width="250"/>

## Contributing `need to figure out if we need it`

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code
of conduct, and the process for submitting pull requests to us.

## Versioning `Need to figure out if we need it`

We use [Semantic Versioning](http://semver.org/) for versioning. For the versions
available, see the [tags on this
repository](https://github.com/PurpleBooth/a-good-readme-template/tags).

## Authors

  - **Edward Avery Rodriguez** - *[LinkedIn](https://www.linkedin.com/in/edward-avery-rodriguez/), [GitHub](https://github.com/TheAveryRodriguez)* 
  - **Kameron Kennedy** - *[LinkedIn](https://www.linkedin.com/in/kameron-kennedy-pe/), [GitHub](https://github.com/kameronk92)* 
  - **Scott DeVoss** - *[LinkedIn](https://www.linkedin.com/in/scott-devoss/), [GitHub](https://github.com/scottdevoss)* 
  - **Sooyung Kim** - *[LinkedIn](https://www.linkedin.com/in/sooyung-kim/), [GitHub](https://github.com/skim1027)* 
  - **Taylor Pubins** - *[LinkedIn](https://www.linkedin.com/in/trpubins/), [GitHub](https://github.com/trpubz)* 

## License `Need to figure out if we need it`

This project is licensed under the [CC0 1.0 Universal](LICENSE.md)
Creative Commons License - see the [LICENSE.md](LICENSE.md) file for
details

## Acknowledgments `Need to figure out if we need it`

  - Hat tip to anyone whose code is used
  - Inspiration
  - etc
