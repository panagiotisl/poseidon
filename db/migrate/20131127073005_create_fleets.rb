class CreateFleets < ActiveRecord::Migration
  def change
    create_table :fleets do |t|
      t.string :name
      t.references :shipping_company, index: true

      t.timestamps
    end
  end
end
