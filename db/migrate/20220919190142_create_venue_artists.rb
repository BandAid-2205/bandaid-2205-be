class CreateVenueArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :venue_artists do |t|
      t.references :venue, foreign_key: true
      t.references :artist, foreign_key: true
      t.integer :booking_status, default: 0

      t.timestamps
    end
  end
end
