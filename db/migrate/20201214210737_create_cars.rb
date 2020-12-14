class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :plate
      t.string :color

      t.timestamps
    end
    add_index :cars, :plate, unique: true
  end
end
