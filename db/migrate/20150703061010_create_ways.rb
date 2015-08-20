class CreateWays < ActiveRecord::Migration
  def change
    create_table :ways do |t|
      t.integer :airport01_id, as: :airport_id
      t.integer :airport02_id, as: :airport_id
      t.integer :airport03_id, as: :airport_id
      t.integer :airport04_id, as: :airport_id
      t.integer :airport05_id, as: :airport_id
      t.integer :airport06_id, as: :airport_id
      t.integer :airport07_id, as: :airport_id
      t.integer :airport08_id, as: :airport_id
      t.integer :airport09_id, as: :airport_id
      t.integer :airport10_id, as: :airport_id
    end
  end
end
