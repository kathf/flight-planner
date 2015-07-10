class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :query
      t.references :airport
      t.timestamps null: false
    end
  end
end
