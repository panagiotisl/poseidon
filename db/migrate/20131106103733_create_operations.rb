class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.integer :agent_id
      t.integer :port_id

      t.timestamps
    end
    add_index :operations, :agent_id
    add_index :operations, :port_id
    add_index :operations, [:agent_id, :port_id], unique: true
  end
end
