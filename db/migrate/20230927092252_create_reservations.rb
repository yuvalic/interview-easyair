class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :check_in
      t.datetime :check_out
      t.float :price, null: false
      t.string :guest_name, null: false
      t.integer :listing_id, null: false
      t.string :status, default: 'new', null: false
      t.string :channel_name

      t.timestamps
    end
  end
end
