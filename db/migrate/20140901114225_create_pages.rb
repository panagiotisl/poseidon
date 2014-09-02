class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :content
      t.references :shipping_company, index: true

      t.timestamps
    end
  end
end
