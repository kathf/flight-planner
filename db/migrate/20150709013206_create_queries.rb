class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer  "destination_id"
      t.integer  "origin_id"
      t.timestamps null: false
    end
  end
end
