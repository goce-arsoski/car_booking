class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.integer :status
      t.date :start_date
      t.date :end_date
      t.references :car, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
