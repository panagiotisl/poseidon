class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :category

      t.timestamps
    end
  end
end
