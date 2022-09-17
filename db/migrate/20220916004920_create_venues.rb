class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :location
      t.string :phone
      t.string :price
      t.string :category, array: true
      t.integer :rating
      t.integer :user_id

      t.timestamps
    end
  end
end
