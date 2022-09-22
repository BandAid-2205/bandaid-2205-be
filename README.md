![](https://img.shields.io/badge/Rails-5.2.8.1-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.7.4-red) ![](https://travis-ci.com/Relocate08/Relocate-Back-End-Rails.svg?branch=main)
## About This Project
[BandAid]() is an app that allows artists and music venues, large and small, to connect with one another through a smooth booking process. Rather than relying on personal and professional networks, BandAid expands the realm of possibilities for artists looking to book a gig and makes it easier for venues to fill their events calendar.

BandAid is an application that utilizes a [frontend](https://github.com/BandAid-2205/bandaid-2205-fe) and a [backend](https://github.com/BandAid-2205/bandaid-2205-be) application. The frontend Application creates a seamless user interface for artists and venues, implements OAuth for login, and makes API calls to the backend. The backend is responsible for receiving requests from the frontend, submitting requests to the Yelp and Last.fm APIs, and return digestible JSON data for the frontend to consume.

## Backend Table of Contents
* [Local Setup](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#local-setup)
* [Deployment](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#deployment)
* [Endpoints](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#endpoints)
  * [Venues](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#venues)
  * [Artists](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#artists)
  * [VenueArtists](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#venueartists)
  * [Last.fm Artist Profile](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#lastfm-artist-profile)
  * [Yelp Venue Profile](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#yelp-venue-profile)
* [Schema](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#schema)
* [Contributors](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/README.md#contributors)

## Local Setup
This project requires:
 * `Ruby 2.7.4`
 * `Rails 5.2.8.1`
### Setup Steps
 * Fork the repository
 * Clone the fork
 * Install gems and set up your database:
   * `bundle install`
   * `rails db:create`
   * `rails db:migrate`
 * Install Figaro
   * `bundle exec figaro install`
 * Update the `application.yml` file with `ENV` variables storing API keys for [Yelp](https://www.yelp.com/developers/documentation/v3/get_started) and [last.fm](https://www.last.fm/api/show/artist.getInfo) (pages for obtaining API keys linked)
## Deployment
  BandAid-2205-BE is deployed remotely on Herkou.
  Base URL: https://bandaid-be.herokuapp.com/
## Endpoints
A Postman collection JSON file is included in this repository as [Mod 3 - BandAid.postman_collection.json](https://github.com/BandAid-2205/bandaid-2205-be/blob/main/Mod%203%20-%20BandAid.postman_collection.json) 
### Venues

#### Return a single Venue’s information based on the User ID associated with the Venue.

* `GET /api/v1/venues/{{:user_id}}`
  * Example Response:

  ```
  {
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
            "bookings": [],
            "artists": [],
            "venue_artists": []
        },
        "relationships": {}
    },
    "included": []
  }
  ```

#### Add a Venue’s information using the User ID associated with the Venue

* `POST /api/v1/venues`
* Request Body         
                  
 | Key (* means required)| Value Data Type | 
 | --- | --- | 
 | name* | String |
 | location* | String |
 | phone* | String (US Numbers only)|
 | price | String ('$', '$$', '$$$', or '$$$$') |
 | category | String |
 | rating | Integer | 
 | user_id* | Integer |
  
  *  Example Request Body:

  ```
    {
      "name": "Trilly Cheesesteaks",
      "location": "3735 Ulloa St, New Orleans, LA 70119",
      "phone": "504-582-9057",
      "price": "$",
      "category": "restaurant",
      "rating": 5,
      "user_id": 10000
    }
  ```

  * Example Response:

  ```
   {
      "data": {
         "id": "5",
         "type": "venue",
         "attributes": {
           "name": "Trilly Cheesesteaks",
           "location": "3735 Ulloa St, New Orleans, LA 70119",
           "phone": "504-582-9057",
           "price": "$",
           "category": "restaurant",
           "rating": 5,
           "user_id": 10000,
           "bookings": [],
           "artists": [],
           "venue_artists": []
       },
       "relationships": {}
     },
     "included": []
    }
  ```

#### Update a Venue’s information using the User ID associated with the Venue

* `PATCH /api/v1/venues/:user_id`
* Request Body 

| Key (* means required)| Value Data Type | 
| --- | --- | 
| name | String |
| location | String |
| phone | String (US Numbers only)|
| price | String ('$', '$$', '$$$', or '$$$$') |
| category | String |
| rating | Integer | 
| user_id | Integer |
  *  Example Request Body:

  ```
    {
      "name": "Trilly",
      "category": "cheesesteak restaurant"
     }
  ```

  *  Example Response:

  ```
    {
      "data": {
      "id": "5",
      "type": "venue",
      "attributes": {
        "name": "Trilly",
        "location": "3735 Ulloa St, New Orleans, LA 70119",
        "phone": "504-582-9057",
        "price": "$",
        "category": "cheesesteak restaurant",
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

#### Destroy a Venue’s information using the User ID associated with the Venue; this also destroys all VenueArtists associated with the Venue

   * `DELETE /api/v1/venues/{{:user_id}}`

### Artists

#### Return a single Artist’s information based on the User ID associated with the Artist.

* `GET /api/v1/artists/{{:user_id}}`
  * Example Response:

   ```
   {
     "data": {
        "id": "7",
        "type": "artist",
        "attributes": {
            "name": "TV Pole Shine",
            "location": "New Orleans",
            "bio": "TV Pole Shine makes music that spans the spectrum from lip-smacking to head-scratching. We call              our music Spasm- Funk. Equal parts professional musicians and theatre makers, TV Pole Shine's catchy                songs are rivaled only by their innovative choreography and radical insistence on audience                          participation.",
             "genre": "jazz",
             "image_path": "https://f4.bcbits.com/img/a1975691682_16.jpg",
             "user_id": 10001,
             "bookings": [],
             "venues": [],
             "venue_artists": []
        },
        "relationships": {}
    },
    "included": []
   }
   ```

#### Create a new Artist

* `POST /api/v1/artists/`
* Request Body 

| Key (* means required)| Value Data Type | 
| --- | --- | 
| name* | String |
| location* | String |
| bio | String |
| genre* | String |
| image_path | String (must be URL for GIF, JPG, or PNG image)|
| user_id* | Integer |

  *  Example Request Body:

  ```
    {
      "name": "TV Pole Shine",
      "location": "New Orleans",
      "bio": "TV Pole Shine makes music that spans the spectrum from lip-smacking to head-scratching. We call our music Spasm- Funk. Equal parts professional musicians and theatre makers, TV Pole Shine's catchy songs are rivaled only by their innovative choreography and radical insistence on audience participation.",
      "genre": "jazz",
      "image_path": "https://f4.bcbits.com/img/a1975691682_16.jpg",
      "user_id": "10001"
    }
  ```


  * Example Response:

  ```
    {
      "data": {
          "id": "7",
          "type": "artist",
          "attributes": {
              "name": "TV Pole Shine",
              "location": "New Orleans",
              "bio": "TV Pole Shine makes music that spans the spectrum from lip-smacking to head-scratching. We call our music Spasm- Funk. Equal parts professional musicians and theatre makers, TV Pole Shine's catchy songs are rivaled only by their innovative choreography and radical insistence on audience participation.",
              "genre": "jazz",
              "image_path": "https://f4.bcbits.com/img/a1975691682_16.jpg",
              "user_id": 10001,
              "bookings": [],
              "venues": [],
              "venue_artists": []
          },
          "relationships": {}
      },
      "included": []
    }
  ```


#### Update an Artist’s information using the User ID associated with the Artist

* `PATCH /api/v1/artists/{{:user_id}}`
* Request Body 

| Key (* means required)| Value Data Type | 
| --- | --- | 
| name | String |
| location | String |
| bio | String |
| genre | String |
| image_path | String (must be URL for GIF, JPG, or PNG image)|
| user_id | Integer |

  *  Example Request Body:

  ```
    {
      "name": "TV Pole Shine",
      "location": "New Orleans, NY",
      "bio": "TV Pole Shine makes music that spans the spectrum from lip-smacking to head-scratching. We call our music Spasm- Funk. Equal parts professional musicians and theatre makers, TV Pole Shine's catchy songs are rivaled only by their innovative choreography and radical insistence on audience participation.",
      "genre": "jazz",
      "image_path": "https://f4.bcbits.com/img/a1975691682_16.jpg",
      "user_id": "10001"
    }
  ```

  * Example Response:

  ``` 
    {
       "data": {
          "id": "10",
          "type": "artist",
          "attributes": {
              "name": "TV Pole Shine",
              "location": "New Orleans, NY",
              "bio": "TV Pole Shine makes music that spans the spectrum from lip-smacking to head-scratching. We call our music Spasm- Funk. Equal parts professional musicians and theatre makers, TV Pole Shine's catchy songs are rivaled only by their innovative choreography and radical insistence on audience participation.",
              "genre": "jazz",
              "image_path": "https://f4.bcbits.com/img/a1975691682_16.jpg",
              "user_id": 10001,
              "bookings": [],
              "venues": [],
              "venue_artists": []
          },
          "relationships": {}
      },
      "included": []
    }
  ```

#### Destroy an Artist’s information using the User ID associated with the Artist; this also destroys all VenueArtists associated with the Artist  

* `DELETE /api/v1/artists/{{:user_id}}`

      Status 204 No Content

### VenueArtists

  #### Return a single VenueArtist based on the User ID of the Venue and the User ID of the Artist associated with the VenueArtist

  * `GET /api/v1/venues/:venue_user_id/venue_artists/:artist_user_id`
  
  *  Example Response Body:

  ```
    {
       "data": {
           "id": "11",
           "type": "venue_artist",
           "attributes": {
               "venue_id": 7,
               "artist_id": 7,
               "booking_status": "pending"
           }
       }
    }
  ```

  #### Create a VenueArtist based on the User ID of the Venue and the User ID of the Artist associated with the VenueArtist

  * `POST /api/v1/venues/:venue_user_id/venue_artists/:artist_user_id`
  
  *  Request Body 
 
 | Key (* means required)| Value Data Type | 
 | --- | --- | 
 | venue_id* | Integer |
 | artist_id* | Integer |
 | booking_status | Integer (0 = pending, 1 = accepted, 2 = rejected; defaults to 0) |

 *  Example Request Body:
    ```
      {
        "venue_id": 10000,
        "artist_id": 10001
      }
    ```

 * Example Response:

    ```
     {
        "data": {
           "id": "11",
           "type": "venue_artist",
           "attributes": {
               "venue_id": 7,
               "artist_id": 7,
               "booking_status": "pending"
           }
       }
      }
    ```

  #### Update a VenueArtist based on the User ID of the Venue and the User ID of the Artist associated with the VenueArtist
 
  * `PATCH /api/v1/venues/:venue_user_id/venue_artists/:artist_user_id`
  *  Request Body
  
 | Key (* means required)| Value Data Type | 
 | --- | --- | 
 | booking_status* | Integer (0 = pending, 1 = accepted, 2 = rejected; defaults to 0) |
 
  *  Example Request Body:
        ```
          {
            "booking_status": 1
          }
        ```

  * Example Response:
    ```
     {
        "data": {
            "id": "11",
            "type": "venue_artist",
            "attributes": {
                "venue_id": 5,
                "artist_id": 11,
                "booking_status": "accepted"
            }
        }
      }
    ```


 
### Last.fm Artist Profile
  #### Return a single Artist’s information that is stored in Last.fm based on the Artist’s name

  * `GET /api/v1/lastfm/search`
  *  Request Body
  
 | Key (* means required)| Value Data Type | 
 | --- | --- | 
 | query* | String (query must be an exact match to the Artist’s name as it is stored in Last.fm (e.g. “Dr. John” or    “dr. john” instead of “dr john” or “john”) |

  * Example Response:

     ```
      {
         "data": {
              "id": "1",
              "type": "artist_poro",
              "attributes": {
                  "name": "The Dirty Dozen Brass Band",
                  "bio": "The Dirty Dozen Brass Band are a New Orleans style brass band which plays R&B and Traditional New Orleans music. Band Members include Charles Joseph, Keith Anderson, Roger Lewis, Kevin Harris, Lionel Batiste, Efrem Towns, Kirk Joseph, Jenell Marshall, Revert Andrews, Gregory Davis, and Raymond Weber. Original band formed in 1975.\n\nThe Dirty Dozen Brass Band \n\nCelebrating over 40 years since their founding in 1977, New Orleans-based Dirty Dozen Brass <a href=\"https://www.last.fm/music/The+Dirty+Dozen+Brass+Band\">Read more on Last.fm</a>",
                  "genre": "jazz",
                  "image_path": "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png"
              }
          }
        }
     ```

   ### Yelp Venue Profile
   #### Return 5 Venues whose information is stored in Yelp and matches the query’s keywords and the location
   * `GET /api/v1/yelp/search`
   * Request Body 

      | Key (* means required)| Value Data Type | 
      | --- | --- | 
      | term | String (e.g. name of venue, type of venue, etc.) |
      | location | String (e.g., “New Orleans”, “NYC”, “4445 Lake St”, etc.) | 
      
   * Example Response:

         ```
           {
              "data": [
             {
                 "id": "RvTHIKHaPVVp8S9cihpi5w",
                 "type": "venue_poro",
                 "attributes": {
                     "name": "The Spotted Cat Music Club",
                     "rating": 4.5,
                     "phone": "",
                     "price": "$$",
                     "location": "623 Frenchmen St  New Orleans, LA 70116",
                     "category": "Jazz & Blues"
                 }
             },
             {
                 "id": "m5-FtgWRd4qA7j0vaOXiXQ",
                 "type": "venue_poro",
                 "attributes": {
                     "name": "Preservation Hall",
                     "rating": 4.5,
                     "phone": "+15045222841",
                     "price": "$$",
                     "location": "726 Saint Peter St  New Orleans, LA 70116",
                     "category": "Music Venues"
                 }
             },
             {
                 "id": "VHnxcKRk0qGxnW1jgVdwGw",
                 "type": "venue_poro",
                 "attributes": {
                     "name": "Tipitina's",
                     "rating": 4.5,
                     "phone": "+15048958477",
                     "price": "$$",
                     "location": "501 Napoleon Ave  New Orleans, LA 70115",
                     "category": "Music Venues"
                 }
             },
             {
                 "id": "7kHvPCBSmRgzDgjO9xXT1g",
                 "type": "venue_poro",
                 "attributes": {
                     "name": "D.B.A. New Orleans",
                     "rating": 4.0,
                     "phone": "+15049423731",
                     "price": "$$",
                     "location": "618 Frenchmen St  New Orleans, LA 70116",
                     "category": "Jazz & Blues"
                 }
             },
             {
                 "id": "v77_hh7gsbpSpjlzSKeq5w",
                 "type": "venue_poro",
                 "attributes": {
                     "name": "One Eyed Jacks",
                     "rating": 4.0,
                     "phone": "+15045698361",
                     "price": "$$",
                     "location": "1104 Decatur St  New Orleans, LA 70116",
                     "category": "Bars"
                 }
             }
         ]} 
         
## Schema

<img width="600" alt="BandAid BE Schema" src="https://user-images.githubusercontent.com/101689311/191354037-5b5657d5-4d30-4ddd-b9f9-53d035d491f4.png">

## Contributors

### Backend 
- **Anna Marie Sterling** - *Turing Student* - [GitHub](https://github.com/AMSterling) - [LinkedIn](https://www.linkedin.com/in/sterling-316a6223a/)
- **Bryan Shears** - *Turing Student* - [GitHub](https://github.com/b-shears) - [LinkedIn](https://github.com/b-shears)
- **Mayu Takeda** - *Turing Student* - [GitHub](https://github.com/okayama-mayu) - [LinkedIn](https://www.linkedin.com/in/mayu-takeda/)
### Frontend 
- **Sunny Moore** - *Turing Student* - [GitHub](https://github.com/sunny-moore) - [LinkedIn](https://www.linkedin.com/in/sunny-moore/)
- **Nicole Esquer** - *Turing Student* - [GitHub](https://github.com/nicole-esquer) - [LinkedIn](https://www.linkedin.com/in/nicole-esquer/)
- **Justin Ramirez** - *Turing Student* - [GitHub](https://github.com/jusrez) - [LinkedIn](https://www.linkedin.com/in/jusrez/)
