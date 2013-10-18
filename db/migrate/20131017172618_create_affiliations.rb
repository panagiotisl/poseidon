class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
