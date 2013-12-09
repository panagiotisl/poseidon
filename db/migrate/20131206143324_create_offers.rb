class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.float :value
      t.boolean :accepted
      t.references :need, index: true
      t.references :agent, index: true

      t.timestamps
    end
  end
end
