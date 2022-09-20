![](https://img.shields.io/badge/Rails-5.2.8.1-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.7.4-red) ![](https://travis-ci.com/Relocate08/Relocate-Back-End-Rails.svg?branch=main)
## About This Project
This project requires: 
* Ruby 2.7.4 
* Rails 5.2.8.1

## Table of Contents 
* [Local Setup](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#local-setup)
* [Deployment](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#deployment)
* [Endpoints](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#endpoints)
* [Schema](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#schema)
* [Contributors](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#contributors)
## Setup Steps
* Fork the repository 
* Clone the fork
* Install gems and set up your database: 
⋅⋅* bundle install
⋅⋅* rails db:create
⋅⋅* rails db;migrate 
* Install Figaro
⋅⋅* bundle exec figaro install
* Update the application.yml file with ENV variables storing API keys for Yelp and Last.fm (pages for obtaining API keys linked)
## Deployment 
  BandAid-2205-BE is deployed remotely on Herkou. 
  Base URL: https://bandaid-be.herokuapp.com/
## Endpoints 
### Venues 
 * Return a single Venue’s information based on the User ID associated with the Venue. (*GET /api/v1/venues/:user_id*)

 * Example Response: 
  ```{
    "data": {
        "id": "6",
        "type": "venue",
        "attributes": {
            "name": "Trilly Cheesesteaks",
            "location": "3735 Ulloa St, New Orleans, LA 70119",
            "phone": "504-582-9057",
            "price": "$",
            "category": "restaurant",
            "rating": 5,
            "user_id": 10000,
            "artists": [],
            "venue_artists": []
        },
        "relationships": {}
    },
    "included": []
  }
  ```

## Schema 
<img width="600" alt="BandAid BE Schema" src="https://user-images.githubusercontent.com/101689311/191354037-5b5657d5-4d30-4ddd-b9f9-53d035d491f4.png">

## Contributors 

- **Anna Marie Sterling** - *Turing Student* - [GitHub](https://github.com/AMSterling) - [LinkedIn](https://www.linkedin.com/in/sterling-316a6223a/)
- **Bryan Shears** - *Turing Student* - [GitHub](https://github.com/b-shears) - [LinkedIn](https://github.com/b-shears)
- **Mayu Takeda** - *Turing Student* - [GitHub](https://github.com/okayama-mayu) - [LinkedIn](https://www.linkedin.com/in/mayu-takeda/)
- **Sunny Moore** - *Turing Student* - [GitHub](https://github.com/sunny-moore) - [LinkedIn](https://www.linkedin.com/in/sunny-moore/)
- **Nicole Esquer** - *Turing Student* - [GitHub](https://github.com/nicole-esquer) - [LinkedIn](https://www.linkedin.com/in/nicole-esquer/)
- **Justin Ramirez** - *Turing Student* - [GitHub](https://github.com/jusrez) - [LinkedIn](https://www.linkedin.com/in/jusrez/)

