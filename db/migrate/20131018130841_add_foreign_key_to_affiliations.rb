class AddForeignKeyToAffiliations < ActiveRecord::Migration
  def change
    add_column :affiliations, :category_id, :integer
  end
end
