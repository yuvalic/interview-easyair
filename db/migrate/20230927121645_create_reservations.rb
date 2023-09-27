class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :checkin_at
      t.datetime :checkout_at
      t.decimal :price
      t.string :guest_name
      t.integer :external_reservation_id
      t.integer :external_listing_id
      t.string :channel_name

      t.timestamps
    end
  end
end
