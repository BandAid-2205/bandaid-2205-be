class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :booking_status, default: 0
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
