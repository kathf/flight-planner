class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :fs
      t.string :iata
      t.string :icao
      t.string :name
      t.string :city
      t.string :city_code
      t.string :country_code
      t.string :country_name
      t.string :region_name
      t.float :latitude
      t.float :longitude
      t.integer :elevation_feet
      t.integer :classification
      t.timestamps null: false
    end
  end
end
