class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name
      t.references :shipping_company, index: true

      t.timestamps
    end
  end
end
