class CreateVoyages < ActiveRecord::Migration
  def change
    create_table :voyages do |t|
      t.string :name
      t.references :ship, index: true
      t.references :port, index: true
      t.date :date
      
      t.timestamps
    end
  end
end
