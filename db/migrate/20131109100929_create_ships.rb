class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name
      t.references :vessel_type
      t.references :fleet, index: true
      t.references :flag, index: true
      t.references :port
      t.integer :registry_no
      t.date :built_date
      t.string :yard_built
      t.integer :imo_no
      t.integer :hull_no
      t.string :call_sign


      t.timestamps
    end
  end
end
