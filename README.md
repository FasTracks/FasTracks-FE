# FasTracks-FE

FasTracks provides a streamlined approach to workout playlist generation after answering simple questions such as genre preference and workout type.  A playlist is optimized based on bpm, danceability, and similar metadata based on user preference.

## Getting Started

These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on deploying the project on a live system.

### Prerequisites

Requirements for the software and other tools to build, test and push 
- [Spotify API Credentials](https://developer.spotify.com/documentation/web-api/concepts/apps)
    - Familiarity with OAuth2.0 authorization

### Notes on Data Flow
This front end portion will conduct OAuth authorization and then pass the data to the backend service responsible for playlist generation.

1.  The front end will authorize for the Spotify user using the following scopes:
   - `playlist-read-private playlist-read-collaborative playlist-modify-public playlist-modify-private`

### Installing

A step by step series of examples that tell you how to get a development
environment running

Ensure to install gems; this project uses bootstrap for mobile first dev

```ruby
bundle install
```

And repeat

    until finished

End with an example of getting some data out of the system or using it
for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Sample Tests

Explain what these tests test and why

    Give an example

### Style test

Checks if the best practices and the right coding style has been used.

    Give an example

## Deployment

Add additional notes to deploy this on a live system

## Built With

  - [Contributor Covenant](https://www.contributor-covenant.org/) - Used
    for the Code of Conduct
  - [Creative Commons](https://creativecommons.org/) - Used to choose
    the license

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code
of conduct, and the process for submitting pull requests to us.

## Versioning

We use [Semantic Versioning](http://semver.org/) for versioning. For the versions
available, see the [tags on this
repository](https://github.com/PurpleBooth/a-good-readme-template/tags).

## Authors

  - **Billie Thompson** - *Provided README Template* -
    [PurpleBooth](https://github.com/PurpleBooth)

See also the list of
[contributors](https://github.com/PurpleBooth/a-good-readme-template/contributors)
who participated in this project.

## License

This project is licensed under the [CC0 1.0 Universal](LICENSE.md)
Creative Commons License - see the [LICENSE.md](LICENSE.md) file for
details

## Acknowledgments

  - Hat tip to anyone whose code is used
  - Inspiration
  - etc
