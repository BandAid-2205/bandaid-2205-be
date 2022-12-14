# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
# puts "Loading PostgreSQL Data dump into local database with command:"
# puts cmd
# system(cmd)

# venue_1 = Venue.create!(name: 'Trilly', location: '123 abc st New Orleans, LA 70119', phone: '555-555-5555', price: '$', category: 'restaurant', rating: 5, user_id: 1)

artist1 = Artist.create!(
    name: "TV Pole Shine",
    location: "New Orleans, LA",
    bio: "TV Pole Shine makes music that spans the spectrum from lip-smacking to head-scratching. We call our music Spasm- Funk. Equal parts professional musicians and theatre makers, TV Pole Shine's catchy songs are rivaled only by their innovative choreography and radical insistence on audience participation.",
    genre: "funk",
    image_path: "https://f4.bcbits.com/img/a1975691682_16.jpg",
    user_id: 1000
  )
artist2 = Artist.create!(
    name: Faker::Music.band,
    location: Faker::Address.full_address,
    bio: Faker::Lorem.paragraph,
    genre: Faker::Music.genre,
    image_path: Faker::Placeholdit.image,
    user_id: 1001
  )
artist3 = Artist.create!(
    name: Faker::Music.band,
    location: Faker::Address.full_address,
    bio: Faker::Lorem.paragraph,
    genre: Faker::Music.genre,
    image_path: Faker::Placeholdit.image,
    user_id: 1002
  )
artist4 = Artist.create!(
    name: Faker::Music.band,
    location: Faker::Address.full_address,
    bio: Faker::Lorem.paragraph,
    genre: Faker::Music.genre,
    image_path: Faker::Placeholdit.image,
    user_id: 1003
  )
artist5 = Artist.create!(
    name: Faker::Music.band,
    location: Faker::Address.full_address,
    bio: Faker::Lorem.paragraph,
    genre: Faker::Music.genre,
    image_path: Faker::Placeholdit.image,
    user_id: 1004
  )

venue1 = Venue.create!(
    name: "Trilly Cheesesteaks",
    location: "3735 Ulloa St, New Orleans, LA 70119",
    phone: "504-582-9057",
    price: "$",
    category: "restaurant",
    rating: 5,
    user_id: 2000
  )
venue2 = Venue.create!(
    name: Faker::Company.name,
    location: Faker::Address.full_address,
    phone: Faker::PhoneNumber.cell_phone,
    price: ['$', '$$', '$$$', '$$$$'].sample,
    category: Faker::Company.industry,
    rating: Faker::Number.within(range: 1..5),
    user_id: 2001
  )
venue3 = Venue.create!(
    name: Faker::Company.name,
    location: Faker::Address.full_address,
    phone: Faker::PhoneNumber.cell_phone,
    price: ['$', '$$', '$$$', '$$$$'].sample,
    category: Faker::Company.industry,
    rating: Faker::Number.within(range: 1..5),
    user_id: 2002
  )

v1a1 = VenueArtist.create!(
  artist_id: artist1.id,
  venue_id: venue1.id,
  booking_status: 1
  )
v2a1 = VenueArtist.create!(
  artist_id: artist1.id,
  venue_id: venue2.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v1a3 = VenueArtist.create!(
  artist_id: artist3.id,
  venue_id: venue1.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v3a3 = VenueArtist.create!(
  artist_id: artist3.id,
  venue_id: venue3.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v2a3 = VenueArtist.create!(
  artist_id: artist3.id,
  venue_id: venue2.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v2a4 = VenueArtist.create!(
  artist_id: artist4.id,
  venue_id: venue2.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v3a5 = VenueArtist.create!(
  artist_id: artist5.id,
  venue_id: venue3.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v1a4 = VenueArtist.create!(
  artist_id: artist4.id,
  venue_id: venue1.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v2a2 = VenueArtist.create!(
  artist_id: artist2.id,
  venue_id: venue2.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
v3a2 = VenueArtist.create!(
  artist_id: artist2.id,
  venue_id: venue3.id,
  booking_status: ['pending', 'accepted', 'rejected'].sample
  )
