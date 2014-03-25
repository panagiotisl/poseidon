class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.references :notification, index: true
      t.references :voyages_port, index: true

      t.timestamps
    end
  end
end
