class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|
      t.references :voyages_port
      t.references :service, index: true

      t.timestamps
    end
  end
end
