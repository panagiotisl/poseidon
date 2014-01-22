class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name
      t.references :vessel_type
      t.references :fleet, index: true
      t.references :flag, index: true

      t.timestamps
    end
  end
end
