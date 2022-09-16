class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :location
      t.text :bio
      t.string :genres, array: true
      t.string :image_path
      t.integer :user_id

      t.timestamps
    end
  end
end
