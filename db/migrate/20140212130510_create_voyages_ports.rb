class CreateVoyagesPorts < ActiveRecord::Migration
  def change
    create_table :voyages_ports do |t|
      t.integer :voyage_id
      t.integer :port_id
      t.date :date
      
      t.timestamps
    end
  end
end
