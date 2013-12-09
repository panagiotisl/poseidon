class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|
      t.references :voyage
      t.references :service, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
