class CreateStopovers < ActiveRecord::Migration
  def change
    create_table :stopovers do |t|
      t.references :airport
      t.timestamps null: false
    end
  end
end
