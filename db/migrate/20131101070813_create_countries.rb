class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso
      t.string :name
      t.string :printableName
      t.string :iso3
      t.integer :numCode

      t.timestamps
    end
  end
end
