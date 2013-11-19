class CreateVesselTypes < ActiveRecord::Migration
  def change
    create_table :vessel_types do |t|
      t.string :category

      t.timestamps
    end
  end
end
