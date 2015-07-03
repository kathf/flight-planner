class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :destination_id, as: :airport_id
      t.integer :origin_id, as: :airport_id
      t.timestamps null: false
    end
  end
end
