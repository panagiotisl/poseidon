class CreateAgentPages < ActiveRecord::Migration
  def change
    create_table :agent_pages do |t|
      t.string :name
      t.text :content
      t.integer :position
      t.references :agent, index: true

      t.timestamps
    end
  end
end
