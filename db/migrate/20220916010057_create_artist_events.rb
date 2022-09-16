class CreateArtistEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_events do |t|
      t.references :artist, foreign_key: true
      t.references :event, foreign_key: true
    end
  end
end
