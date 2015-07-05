class CreateWays < ActiveRecord::Migration
  def change
    create_table :ways do |t|
      t.integer :destination_id, as: :airport_id
      t.integer :origin_id, as: :airport_id
      t.integer :stopovers_array, array: true, default: []
      t.timestamps null: false
    end
  end
end
