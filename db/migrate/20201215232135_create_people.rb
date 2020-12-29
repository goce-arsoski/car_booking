class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthdate

      t.timestamps
    end
  end
end
