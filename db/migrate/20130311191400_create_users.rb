class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin
      t.integer :shipping_company_id
      t.integer :agent_id
      t.string :type

      t.timestamps
    end
  end
end
