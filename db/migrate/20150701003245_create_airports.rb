class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :iata
      t.string :iso
      t.binary :status
      t.string :continent
      t.float :lon
      t.float :lat
      t.string :size
      t.timestamps null: false
    end
  end
end
