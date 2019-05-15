class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :place, foreign_key: true
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
